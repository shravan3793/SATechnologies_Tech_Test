import XCTest
import Combine

@testable import SATechnologies_Tech_Test

final class RegisterViewModelTests: XCTestCase {
    
    var viewModel: RegisterViewModel!
    fileprivate var mockAPIManager: MockAPIManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        APIManager.shared = mockAPIManager
        viewModel = RegisterViewModel()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }
    
    func testRegistrationSuccess() {
        let user = AuthenticationModel(email: "newuser@example.com", password: "password123")
        mockAPIManager.mockResponseModel = ResponseModel(status: 200, error: nil)
        
        let expectation = XCTestExpectation(description: "Registration Success")
        var statusMessage = ""
        viewModel.statusMessageRegistration.sink { message in
            statusMessage = message
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.registerUser(user: user)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(statusMessage, RegistrationStatus.success.rawValue)
    }
    
    
    func testRegistrationFailure_UserExists() {
        let user = AuthenticationModel(email: "existinguser@example.com", password: "password123")
        mockAPIManager.mockResponseModel = ResponseModel(status: 401, error: RegistrationStatus.userExists.rawValue)
        
        let expectation = XCTestExpectation(description: "User Already Exists")
        var statusMessage = ""
        viewModel.statusMessageRegistration.sink { message in
            statusMessage = message
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.registerUser(user: user)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(statusMessage, RegistrationStatus.userExists.rawValue)
    }
}
