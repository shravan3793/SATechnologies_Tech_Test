import Combine

class Inspection_QnA_ViewModel{
    
    init(){}
    var cancellables = Set<AnyCancellable>()
    
    
    func updateCategory(category:Category?){
        DataManager.shared.updateCategoryData(category: category)
    }
    
}

