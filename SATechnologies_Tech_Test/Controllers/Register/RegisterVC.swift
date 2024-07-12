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
       initialSetup()
    }
    
    
    @IBAction func registerUser(_ sender: Any) {
        viewModel.registerUser(user: AuthenticationModel(email: usernameField.text ?? "",
                                                         password: passwordField.text ?? ""))
    }
    
    func initialSetup(){
        self.title = "Register"
        self.passwordField.isSecureTextEntry = true
        viewModel.$statusMessageRegistration.sink(receiveValue: { message in
            if !message.isEmpty{
                DispatchQueue.main.async {
                    self.showAlertView(message: message)
                    self.usernameField.text = nil
                    self.passwordField.text = nil
                }
            }
        }).store(in: &cancellables)
    }
}
