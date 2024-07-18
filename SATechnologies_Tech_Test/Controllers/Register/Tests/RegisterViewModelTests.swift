//import XCTest
//import Combine
//@testable import SATechnologies_Tech_Test
//
//
//final class RegisterViewModelTests: XCTestCase {
//
//    var viewModel : RegisterViewModel!
//    var mockAPIManager : MockAPIManager!
//    var cancellables : Set<AnyCancellable>!
//        
//    override func setUp() {
//        super.setUp()
//        viewModel = RegisterViewModel()
//        mockAPIManager = MockAPIManager()
//        cancellables = []
//    }
//    
//    override func tearDown() {
//        viewModel = nil
//        mockAPIManager = nil
//        cancellables = nil
//        super.tearDown()
//    }
//    
//    func testRegistrationSuccess(){
//        let user = AuthenticationModel(email: "test@example.com", password: "password123")
//        mockAPIManager.mockResponseModel = ResponseModel(status: 200, error: nil)
//        
//        let expectation = XCTestExpectation(description: "Registration Success")
//        viewModel.$isRegistered.sink { status in
//            if status{
//                expectation.fulfill()
//            }
//        }.store(in: &cancellables)
//        viewModel.registerUser(user: user)
//        
//        wait(for: [expectation])
//        XCTAssertTrue(viewModel.isRegistered)
//    }
//    
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//}
