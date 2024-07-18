import Combine
import Foundation

@testable import SATechnologies_Tech_Test

class MockDataManager: DataManager {
    var mockInspectionData: Inspection?
    var shouldThrowError: Bool = false
    var errorToThrow: DataManagerError = .documentDirectoryNotFound

    override var inspectionData: Inspection? {
        get { return mockInspectionData }
        set { mockInspectionData = newValue }
    }

    override func getFileURL() throws -> URL {
        if shouldThrowError {
            throw errorToThrow
        }
        // Return a URL that would normally not be used, as file operations are mocked
        return URL(fileURLWithPath: "/tmp/mockinspectionData.json")
    }

    override func saveDataLocally() throws {
        if shouldThrowError {
            throw errorToThrow
        }
        // Mock behavior: simply do nothing or simulate success
    }

    override func fetchData() throws {
        if shouldThrowError {
            throw errorToThrow
        }
        // Mock behavior: simulate data fetching by directly setting the data
        self.inspectionData = mockInspectionData
    }

    override func updateCategoryData(category: InspectionCategory?) {
        if shouldThrowError {
            // Simulate failure in updating data
            return
        }
        super.updateCategoryData(category: category)
    }
    
    
}
