
import UIKit
extension HistoryVC:UITableViewDataSource,UITableViewDelegate{
    var data : InspectionModel?{
        return historyViewModel.inspectionData
    }
    
    var categories : [InspectionCategory]?{
        data?.survey.categories
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categories?.count ?? 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let str : String? = "Category: " + (categories?[section].name ?? "")
        return str
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getRowsInSection(section: section)
    }
    
    func getRowsInSection(section:Int) -> Int{
        guard let categories else {
            return 0
        }
        let questions = categories[section].questions
        return questions.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categories else{ return UITableViewCell()}
        let currentCategory = categories[indexPath.section]
        let currentQuestion = getCurrentQuestion(forCategory: currentCategory, indexPath: indexPath)
        
        if indexPath.row % 2 == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionTableViewCell
            else { return UITableViewCell() }
            
            cell.cellSetup(questionNumber: indexPath.row/2 + 1, text: currentQuestion.name)
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerTableViewCell
            else { return UITableViewCell() }
            
            cell.cellSetup(answerText: getSelectedAnswer(question: currentQuestion))
            return cell
        }
    }
    
    func getCurrentQuestion(forCategory category:InspectionCategory,indexPath:IndexPath) -> Question{
        category.questions[indexPath.row/2]
    }
    func getSelectedAnswer(question:Question) -> String{
        question.answerChoices.first{$0.id == question.selectedAnswerChoiceId}?.name  ?? String()
    }
}
