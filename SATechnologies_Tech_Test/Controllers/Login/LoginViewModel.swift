
import Foundation
import Combine
class LoginViewModel{
    
    @Published var isAuthenticationSuccess : Bool = false
    
    init(){}
    
    func callLoginApi(user:AuthenticationModel){
        Task{
            do{
                let reponse = try await APIManager.shared.request(endPoint: .login,userInput: user) 
            }catch{
                print("Error")
            }
            
        }
        
    }
}
