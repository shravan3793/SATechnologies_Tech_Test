import Combine

enum RegistrationStatus : String{
    case success = "Registration was successful (both the email and password fields were provided)"
    case unSuccessful = "Registration was unsuccessful due to one or both fields missing from the JSON"
    case userExists = "User already exists"
    case unknownError = "Unknown Error"
}

class RegisterViewModel{
 
    @Published var statusMessageRegistration = String()
    var cancellables = Set<AnyCancellable>()

    
    init() {
    }
    
    func registerUser(user:AuthenticationModel){
        Task{
            do {
                try await APIManager.shared.request(endPoint: .register, userInput: user)
                APIManager.shared.$responseModel.sink { response in
                    guard let status = response?.status else {return}
                    switch status{
                    case 200:
                        self.statusMessageRegistration = RegistrationStatus.success.rawValue
                    case 400:
                        self.statusMessageRegistration = response?.error ?? RegistrationStatus.unSuccessful.rawValue
                    case 401:
                        self.statusMessageRegistration = response?.error ??  RegistrationStatus.userExists.rawValue
                    default:
                        self.statusMessageRegistration = RegistrationStatus.unknownError.rawValue
                    }
                }.store(in: &cancellables)
            }catch{
                print(error)
            }
            
        }
        
    }
}
