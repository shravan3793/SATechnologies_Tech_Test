import Combine

enum RegistrationStatus : String{
    case success = "Registration was successful (both the email and password fields were provided)"
    case unSuccessful = "Registration was unsuccessful due to one or both fields missing from the JSON"
    case userExists = "User already exists"
    case unknownError = "Unknown Error"
}

class RegisterViewModel{
    
    var statusMessageRegistration = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setupBindings()
    }
    
    private func setupBindings(){
        APIManager.shared.responseModel.sink { [weak self] response in
            guard let response else {return}
            self?.handleResponseModel(response)
        }.store(in: &cancellables)
    }
    
    private func handleResponseModel(_ response:ResponseModel){
        guard let status = response.status else {return}
        switch status{
        case 200:
            self.statusMessageRegistration.send(RegistrationStatus.success.rawValue)
        case 400:
            self.statusMessageRegistration.send(response.error ?? RegistrationStatus.unSuccessful.rawValue)
        case 401:
            self.statusMessageRegistration.send(response.error ??  RegistrationStatus.userExists.rawValue)
        default:
            self.statusMessageRegistration.send(RegistrationStatus.unknownError.rawValue)
        }
    }
    
    func registerUser(user:AuthenticationModel){
        Task{
            do {
                try await APIManager.shared.request(endPoint: .register, userInput: user)
            }catch{
                self.statusMessageRegistration.send(RegistrationStatus.unknownError.rawValue)
            }
        }
    }
}
