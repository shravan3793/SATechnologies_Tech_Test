import UIKit

extension Inspection_QnA_VC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        arrQuestions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        arrQuestions[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrQuestions[section].answerChoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answer", for: indexPath)
        let currentQuestion = arrQuestions[indexPath.section]
        let arrAnswers = currentQuestion.answerChoices
        let currentAnswer = arrAnswers[indexPath.row]
        cell.textLabel?.text = currentAnswer.name
        let isSelected = currentQuestion.selectedAnswerChoiceId == currentAnswer.id
        print(isSelected)
        cell.setSelected(isSelected, animated: true)
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }

}

extension Inspection_QnA_VC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentQuestion = arrQuestions[indexPath.section]
        arrQuestions[indexPath.section].selectedAnswerChoiceId = currentQuestion.answerChoices[indexPath.row].id
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
    }
}
