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
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getNewInspectionsData()
    }
    
    func initialSetup(){
        inspectionTableView.dataSource = self
        viewModel.$inspectionData.sink { inspectionData
            in
            self.data = inspectionData
        }.store(in: &cancellables)
    }
}
