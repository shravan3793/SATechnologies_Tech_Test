//import XCTest
//import Combine
//
//@testable import SATechnologies_Tech_Test
//
//class MockAPIManager: APIManager{
//    var mockResponseModel: ResponseModel?
//    
//    override func request<T>(endPoint: EndPoint, userInput: T = EmptyInput()) async throws where T : Encodable {
//        try await Task.sleep(nanoseconds: 500 * 1_000_000)
//        self.responseModel = mockResponseModel
//    }
//}
//
//final class LoginViewModelTests: XCTestCase{
//
//    
//    var viewModel: LoginViewModel!
//    var mockAPIManager : MockAPIManager!
//    var cancellables: Set<AnyCancellable>!
//    
//    override func setUp() {
//        super.setUp()
//        mockAPIManager = MockAPIManager()
//        APIManager.shared = mockAPIManager
//        viewModel = LoginViewModel()
//        cancellables = []
//    }
//    
//    
//    override func tearDown() {
//        viewModel = nil
//        mockAPIManager = nil
//        cancellables = nil
//        super.tearDown()
//    }
//    
//    func testLoginSuccess(){
//        let user = AuthenticationModel(email: "test@example.com", password: "password123")
//        mockAPIManager.mockResponseModel = ResponseModel(status: 200, error: nil)
//        
//        let expectation = XCTestExpectation(description: "Login Success")
//        viewModel.isAuthenticationSuccess.sink { isSuccess in
//            if isSuccess{
//                expectation.fulfill()
//            }
//        }.store(in: &cancellables)
//     
//        viewModel.callLoginApi(user:user)
//        
//        wait(for: [expectation], timeout: 1.0)
//        XCTAssertTrue(viewModel.isAuthenticationSuccess)
//    }
//    
//    func testLogin_InvalidCredentails(){
//        let user = AuthenticationModel(email: "test@example.com", password: "wrongPassword")
//        mockAPIManager.mockResponseModel = ResponseModel(status: 401, error: "Invalid user or password")
//        viewModel.callLoginApi(user: user)
//        
//        XCTAssertEqual(viewModel.statusMessage, "")
//    }
//}
