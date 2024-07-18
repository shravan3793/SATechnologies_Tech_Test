import Foundation
import UIKit
extension InspectionVC : UITableViewDataSource{
    
    var categories : [InspectionCategory]?  {
        return data?.survey.categories
    }
    
    var inspectionType: String?{
        return data?.inspectionType.name
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        inspectionType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
            let category = categories?[indexPath.row]
            cell.textLabel?.text = category?.name
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            return cell
    }    
}

extension InspectionVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category  = categories?[indexPath.row] else {return}
        loadCategoryWiseQuestions(category: category)
        
    }
    
    
    func loadCategoryWiseQuestions(category:InspectionCategory){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "InspectionStoryboard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Inspection_QnA_VC") as? Inspection_QnA_VC else {return}
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            vc.category = category
        }
    }
}

