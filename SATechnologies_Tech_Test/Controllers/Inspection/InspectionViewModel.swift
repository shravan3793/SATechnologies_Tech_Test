import Combine

enum InspectionStatus : String{
    case success = "Submitted Successfully"
    case anErrorOccured = "There was an error (such as the inspection not having an id)"
    case unknownError

}

class InspectionViewModel{
        
    init(){}
    var cancellables = Set<AnyCancellable>()
    @Published var inspectionData :  InspectionModel?
    @Published var message : String?
    
    func getNewInspectionsData(){
        Task{
            
            do {
                try DataManager.shared.fetchData()
            }catch
            {
                print(error)
            }
            
            if DataManager.shared.inspectionData == nil{
                do{
                    try await APIManager.shared.request(endPoint: .startInspection)
                }catch{
                    print(error)
                }
            }            
            
            DataManager.shared.$inspectionData.sink { data in
                self.inspectionData = data?.inspection
            }.store(in: &cancellables)
        }
    }
    
    
    
    func saveDataToServer(){
        guard let data = DataManager.shared.inspectionData else {
            message = InspectionStatus.unknownError.rawValue
            return
        }
        
        Task{
            do{
                try await APIManager.shared.request(endPoint: .submitInspection,userInput: data)
                
                APIManager.shared.$responseModel.sink { response in
                    guard let status =  response.status else{
                        self.message = InspectionStatus.unknownError.rawValue
                        return
                    }
                    
                    switch status{
                    case 200:
                        let totalScore = String(describing: "\(self.getTotalScore())")
                        self.message = InspectionStatus.success.rawValue + "\n The total score is \(totalScore)"
                    case 500:
                        self.message = response.error
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

// total score calulcation
extension InspectionViewModel {
    func getTotalScore() -> Double {
        guard let categories = DataManager.shared.inspectionData?.inspection.survey.categories else {
            return 0
        }
        
        let data = categories.map { category in
            category.questions.map { question in
                guard let answer = question.answerChoices.first(where: { answer in
                    answer.id == question.selectedAnswerChoiceId
                }) else {
                    return 0.0
                }
                return answer.score
            }
        }
        
        let sum = data.reduce(0.0) { partialResult, arrAnswerScores in
            partialResult + arrAnswerScores.reduce(0.0, +)
        }
        return sum
    }
}

