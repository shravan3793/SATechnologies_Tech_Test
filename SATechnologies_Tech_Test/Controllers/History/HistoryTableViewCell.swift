import UIKit

class QuestionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .black
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func cellSetup(questionNumber:Int,text:String){
        textLabel?.text = "Question \(questionNumber) : " + text
    }

}


class AnswerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .darkGray
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func cellSetup(answerText:String){
        textLabel?.text = "Answer : " + answerText
    }

}
