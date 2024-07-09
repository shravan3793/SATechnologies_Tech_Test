import UIKit

extension UIViewController{
    func showAlertView(message:String){
        let alertController = UIAlertController(title: "SATechnologies_Tech_Test", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

enum AlertMessages : String{
    case validEmail = "Please Enter Valid email"
    case validPassword = "Please Enter Valid Password"
    case confirmPassword = "Please confirm password"
    case registrationSuccess = "Registration Successful"
}
