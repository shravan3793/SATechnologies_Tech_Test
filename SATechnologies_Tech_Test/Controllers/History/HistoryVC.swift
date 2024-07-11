import UIKit
import Combine
class HistoryVC: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    let historyViewModel = HistoryViewModel()
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "History"
        historyTableView.isUserInteractionEnabled = false
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historyTableView.rowHeight = UITableView.automaticDimension
        historyTableView.estimatedRowHeight = 44.0

        historyViewModel.getInspectionDataHistory()
        historyViewModel.$inspectionData.sink { inspectionData in
            guard inspectionData != nil else{return}
                DispatchQueue.main.async {
                    self.historyTableView.reloadData()
                }
        }.store(in: &cancellables)
    }
    
}