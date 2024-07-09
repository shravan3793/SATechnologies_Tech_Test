import Combine

class InspectionViewModel{
        
    init(){}
    var cancellables = Set<AnyCancellable>()
    @Published var inspectionData :  InspectionModel?
    func getNewInspectionsData(){
        Task{
            do{
                try await APIManager.shared.request(endPoint: .startInspection)
                APIManager.shared.$responseData.sink { data in
                    guard let inspectionData = data as? Inspection else {
                        print("error")
                        return
                    }
                    self.inspectionData = inspectionData.inspection
                }.store(in: &cancellables)
            }catch{
                print(error)
            }
           
        }
    }
}
