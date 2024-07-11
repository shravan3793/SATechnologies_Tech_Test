import Combine

class HistoryViewModel{
    init() {
        
    }
    
    @Published var inspectionData :  InspectionModel?
    var cancellables = Set<AnyCancellable>()
    
    func getInspectionDataHistory(){
        Task{
            
            do {
                try DataManager.shared.fetchData()
                DataManager.shared.$inspectionData.sink { data in
                    self.inspectionData = data?.inspection
                }.store(in: &cancellables)
            }catch
            {
                inspectionData = nil
            }
        }
        
    }
}
