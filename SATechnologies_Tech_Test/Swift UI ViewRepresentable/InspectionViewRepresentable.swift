import SwiftUI

struct InspectionViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "InspectionStoryboard", bundle: nil)
        let vcInspection = storyboard.instantiateViewController(withIdentifier: "inspectionNavigation")
        if let navController = vcInspection as? UINavigationController {
                  navController.isNavigationBarHidden = true
        }
        return vcInspection
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
