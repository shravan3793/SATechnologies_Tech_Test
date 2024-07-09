import UIKit
import Combine
class InspectionVC: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var inspectionTableView: UITableView!
    let viewModel = InspectionViewModel()
    var data : InspectionModel?{
        didSet{
            DispatchQueue.main.async {
                self.inspectionTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNewInspectionsData()
        initialSetup()
    }
    
    func initialSetup(){
        inspectionTableView.dataSource = self
        inspectionTableView.delegate = self
        viewModel.$inspectionData.sink { inspectionData
            in
            self.data = inspectionData
            DispatchQueue.main.async {
                guard let inspectionArea = self.data?.area.name else{
                    return
                }
                self.title =  "\(inspectionArea.uppercased())"
            }            
        }.store(in: &cancellables)
    }
    
    
    @IBAction func saveDataToServer(_ sender: Any) {
        viewModel.saveDataToServer()
        viewModel.$message.sink { message in
            if let message{
                DispatchQueue.main.async {
                    self.showAlertView(message: message)
                }
                
            }
        }.store(in: &cancellables)
    }
}

