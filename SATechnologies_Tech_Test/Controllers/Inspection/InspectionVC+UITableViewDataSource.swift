import Foundation
import UIKit
extension InspectionVC : UITableViewDataSource{
    
    var categories : [Category]?  {
        return data?.survey.categories
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categories?[section].name
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let questionsCount = categories?[section].questions.count else { return 0 }
        return questionsCount * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "question", for: indexPath)
            let category = categories?[indexPath.section]
            cell.textLabel?.text = category?.questions[indexPath.row/2].name
            cell.isUserInteractionEnabled = false
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "answer", for: indexPath)
            
            cell.isUserInteractionEnabled = false
            return cell
        }
        
    }    
}


extension InspectionVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
}

