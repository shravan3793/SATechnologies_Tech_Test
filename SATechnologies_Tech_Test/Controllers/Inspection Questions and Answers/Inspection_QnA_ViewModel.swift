import Combine

class Inspection_QnA_ViewModel{

    var cancellables = Set<AnyCancellable>()
    @Published var message : String?
    
    init(){
        setupBinding()
    }
    
     func setupBinding(){
        APIManager.shared.responseModel.sink { [weak self] response in
            self?.handleResponse(response: response)
        }.store(in: &cancellables)
    }
    
    private func handleResponse(response:ResponseModel?){
        guard let status =  response?.status else{
            self.message = InspectionStatus.unknownError.rawValue
            return
        }
        
        switch status{
        case 200:
            self.message = InspectionStatus.success.rawValue
        case 500:
            self.message = response?.error
        default:
            self.message = InspectionStatus.unknownError.rawValue
        }
    }
    
    
    func updateCategory(category:InspectionCategory?){
        DataManager.shared.updateCategoryData(category: category)
    }
    
    func saveDataToServer(){
        do{
            try DataManager.shared.saveDataLocally()
        }catch{
            print("Failed to save data : \(error)")
        }
                
        guard let data = DataManager.shared.inspectionData else {
            message = InspectionStatus.unknownError.rawValue
            return
        }
        
        Task{
            do{
                try await APIManager.shared.request(endPoint: .submitInspection,userInput: data)
            }catch{
                print("Failed to submit inspection: \(error)")
            }
        }
    }
}
