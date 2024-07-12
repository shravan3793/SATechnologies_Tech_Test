extension Inspection_QnA_ViewModel{
    
    func saveDataToServer(){
        try? DataManager.shared.saveDataLocally()
        guard let data = DataManager.shared.inspectionData else {
            message = InspectionStatus.unknownError.rawValue
            return
        }
        
        Task{
            
            do{
                try await APIManager.shared.request(endPoint: .submitInspection,userInput: data)
                
                APIManager.shared.$responseModel.sink { response in
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
                }.store(in: &cancellables)
                
            }catch{
                print(error)
            }
           
        }
    }
}
