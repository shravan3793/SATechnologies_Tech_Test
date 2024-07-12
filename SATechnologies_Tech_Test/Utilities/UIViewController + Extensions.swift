import UIKit

extension UIViewController{
    func showAlertView(message:String){
        let alertController = UIAlertController(title: "SATechnologies_Tech_Test", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
