import UIKit
import Combine
class HistoryVC: UIViewController {
    
    @IBOutlet weak var inspectionType: UILabel!
    @IBOutlet weak var inspectionArea: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    let historyViewModel = HistoryViewModel()
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyViewModel.getInspectionDataHistory()
    }
    
    func initialSetup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "History"
        historyTableView.isUserInteractionEnabled = true
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historyTableView.rowHeight = UITableView.automaticDimension
        historyTableView.estimatedRowHeight = 44.0

        
        historyViewModel.$inspectionData.sink { inspectionData in
            guard let inspectionData else{return}
                DispatchQueue.main.async {
                    self.inspectionType.attributedText = self.getAttributedText(title: "Inspection Type", value: inspectionData.inspectionType.name)
                    self.inspectionArea.attributedText = self.getAttributedText(title: "Inspection Area", value: inspectionData.area.name)
                    self.historyTableView.reloadData()
                    
                }
        }.store(in: &cancellables)
    }
    
    func getAttributedText(title:String, value:String?) -> NSAttributedString{
        let value = value ?? ""

        let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        let lightAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.darkGray]

        let blackAttributedString = NSAttributedString(string: title + " : ", attributes: blackAttributes)
        let lightAttributedString = NSAttributedString(string: value, attributes: lightAttributes)

        let attributedString = NSMutableAttributedString()
        attributedString.append(blackAttributedString)
        attributedString.append(lightAttributedString)

        return attributedString

    }
}
