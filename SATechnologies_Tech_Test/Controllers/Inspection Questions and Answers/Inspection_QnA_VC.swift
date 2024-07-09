import UIKit
import Combine

class Inspection_QnA_VC: UIViewController {
    var cancellables = Set<AnyCancellable>()
    @IBOutlet weak var questionsTable: UITableView!
    var inspectionQnAViewModel = Inspection_QnA_ViewModel()
    var category : Category?{
        didSet{
            self.reloadTableView()
        }
    }
    
    
   @Published var arrQuestions : [Question] = []{
        didSet{
            self.category?.questions = self.arrQuestions
            self.inspectionQnAViewModel.updateCategory(category: category)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        questionsTable.dataSource = self
        questionsTable.delegate = self
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            guard let questions = self.category?.questions else {return}
            self.arrQuestions = questions
            self.questionsTable.reloadData()
            self.title = self.category?.name
        }
    }
}
