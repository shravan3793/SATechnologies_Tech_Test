import UIKit
import Combine
class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let viewModel = LoginViewModel()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInspectionView()
        initialSetup()

    }
    
    func initialSetup(){
        passwordField.isSecureTextEntry = true
        viewModel.$isAuthenticationSuccess
            .sink { completion in
                switch completion {
                case .finished:
                    print("Authentication process finished.")
                case .failure(let error):
                    print("Received error: \(error)")
                }
            } receiveValue: { isSuccess in
                if isSuccess {
                    self.loadInspectionView()
                } else {
                    print("Authentication failed.")
                }
            }
            .store(in: &viewModel.cancellables)

        viewModel.$statusMessage.sink(receiveValue: { message in
            if !message.isEmpty{
                DispatchQueue.main.async {
                    self.showAlertView(message: message)
                }
            }
        }).store(in: &cancellables)
        
    }
    
    func loadInspectionView(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "InspectionStoryboard", bundle: nil)
            let vcInspection = storyboard.instantiateViewController(withIdentifier: "InspectionVC")
            vcInspection.modalPresentationStyle = .fullScreen
            self.present(vcInspection, animated: true)
        }        
    }
    
    @IBAction func loginUser(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        viewModel.callLoginApi(user: AuthenticationModel(email: username, password: password))
    }
    

}

