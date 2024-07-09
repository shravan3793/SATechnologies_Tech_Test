import Combine
import Foundation
class DataManager{
    static let shared = DataManager()
    
    private init(){}
    
    @Published var inspectionData:Inspection?
    
    private func getFileURL() throws -> URL{
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            throw NSError(domain: "FileError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Document directory not found."])
        }
        
        let fileURL = documentDirectory.appendingPathComponent("inspectionData")
        print(fileURL)
        return fileURL
    }
    
    func saveDataLocally()  throws{
     
        do{
            guard let inspectionData = inspectionData else {
                return
            }
            let data = try JSONEncoder().encode(inspectionData)
            try data.write(to: getFileURL())
            print("InspectionModel saved successfully.")
        }catch{
            throw error
        }
    
    }
    
    func fetchData() throws{
        do{
            let data = try Data(contentsOf: getFileURL())
            inspectionData = try JSONDecoder().decode(Inspection.self, from: data)
        }catch{
            throw error
        }
        
    }
    
    func updateCategoryData(category:Category?){
        guard let category = category,
              let index = inspectionData?.inspection.survey.categories.firstIndex(where: { item in
                  return item.id == category.id
              })
        else{
            return
        }
        
        inspectionData?.inspection.survey.categories[index] = category
    }
}
