import UIKit
import Combine
class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup(){
        passwordField.isSecureTextEntry = true
       
        viewModel.isAuthenticationSuccess.sink(receiveValue: { isSuccess in
            if isSuccess {
                self.loadInspectionView()
            }
        }).store(in: &cancellables)

        viewModel.statusMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { message in
                self.showAlertView(message: message ?? "")
        }).store(in: &cancellables)
        
    }
    
    func loadInspectionView(){
            let storyboard = UIStoryboard(name: "InspectionStoryboard", bundle: nil)
            let vcInspection = storyboard.instantiateViewController(withIdentifier: "tabBar")
            vcInspection.modalPresentationStyle = .fullScreen
            self.present(vcInspection, animated: true)
    }
    
    @IBAction func loginUser(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        viewModel.callLoginApi(user: AuthenticationModel(email: username, password: password))
    }
    

}

