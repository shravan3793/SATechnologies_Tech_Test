import UIKit
import Combine
class RegisterVC: UIViewController {
    
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var confirmPasswordField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    private let viewModel = RegisterViewModel()
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup(){
        self.title = "Register"
        self.passwordField.isSecureTextEntry = true
        bindViewModel()
    }
    
    private func bindViewModel(){
        viewModel.statusMessageRegistration
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] message in
                self?.showAlertView(message: message)
                self?.clearTextFields()
            }).store(in: &cancellables)
    }
    
    private func clearTextFields(){
        self.usernameField.text = nil
        self.passwordField.text = nil
    }
    
    @IBAction private func registerUser(_ sender: Any) {
        let userName = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let user = AuthenticationModel(email: userName, password: password)
        viewModel.registerUser(user:user)
    }
}
