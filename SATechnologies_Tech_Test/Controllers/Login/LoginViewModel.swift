
import Foundation
import Combine

enum LoginStatus: String{
    case success = "Login was successful (the user was previously registered with the /api/register endpoint)"
    case missingFields = "email or password fields are missing from the JSON"
    case invalidCrendetials = "if the user does not exist or the credentials are incorrect"
    case unknownError = "Unknown Error"
}


class LoginViewModel : ObservableObject{
    
    @Published var isAuthenticationSuccess = false
    
    @Published var statusMessage = String()
    var cancellables = Set<AnyCancellable>()
    init(){}
    
    func callLoginApi(user:AuthenticationModel){
        Task{
            do {
                try await APIManager.shared.request(endPoint: .login, userInput: user)
                APIManager.shared.$responseModel
                    .receive(on: DispatchQueue.main)
                    .sink { response in
                    guard let status = response.status else {return}
                    switch status{
                    case 200:
                        self.isAuthenticationSuccess = true
                    case 400:
                        self.statusMessage = response.error ?? LoginStatus.missingFields.rawValue
                    case 401:
                        self.statusMessage = response.error ?? LoginStatus.invalidCrendetials.rawValue
                    default:
                        self.statusMessage = LoginStatus.unknownError.rawValue
                    }
                }.store(in: &cancellables)
            }catch{
                print(error)
            }
            
        }
    }
}
