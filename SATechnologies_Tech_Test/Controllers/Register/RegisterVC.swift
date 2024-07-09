import UIKit
import Combine
class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let viewModel = RegisterViewModel()
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$statusMessage.sink(receiveValue: { message in
            if message != RegistrationStatus.unknownError.rawValue{
                DispatchQueue.main.async {
                    self.showAlertView(message: message)
                }
            }
        }).store(in: &cancellables)
    }
    
    @IBAction func registerUser(_ sender: Any) {
        viewModel.registerUser(user: AuthenticationModel(email: usernameField.text ?? "",
                                                         password: passwordField.text ?? ""))
    }
    
    func validations(){
        
    }
}
