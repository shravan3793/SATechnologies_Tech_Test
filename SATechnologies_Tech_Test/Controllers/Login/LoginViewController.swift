import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        viewModel.callLoginApi(user: AuthenticationModel(email: username, password: password))
    }
    
    @IBAction func registerAUser(_ sender: Any) {
        
    }
    
}

