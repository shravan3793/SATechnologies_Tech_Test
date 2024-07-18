import XCTest
import Combine

@testable import SATechnologies_Tech_Test

//final class APIManagerTests: XCTestCase {
//    
//    var apiManager: APIManager!
//    var mockURLSession : MockURLSession!
//    var cancellables : Set<AnyCancellable>!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        mockURLSession = MockURLSession()
//        apiManager = APIManager(urlSession: mockURLSession)
//        cancellables = []
//    }
//
//    override func tearDownWithError() throws {
//        mockURLSession = nil
//        apiManager = nil
//        cancellables = nil
//        try super.tearDownWithError()
//    }
//    
//    func testRequest_LoginEndPoint_Success() async throws{
//
//        //1. generate mock session
//        let mockSession = MockURLSession()
//        mockSession.response = HTTPURLResponse(url: EndPoint.login.url()!,
//                                              statusCode: 200,
//                                              httpVersion: nil,
//                                              headerFields: nil)
//        mockURLSession = mockSession
//        
//        //2. set expectations
//        let expectation = XCTestExpectation(description: "Fetches Data Successfully")
//        
//        //3. verify expectations
//        apiManager.responseModel.sink { responseModel in
//            if let responseModel,
//               responseModel.status == 200{
//                XCTAssertNil(responseModel.error)
//                expectation.fulfill()
//            }
//        }.store(in: &cancellables)
//        
//        try await apiManager.request(endPoint: .login)
//        await fulfillment(of: [expectation], timeout: 5)
//    }
//    
//    func testRequest_LoginEndPoint_Failure() async throws{
//        //1. generate mock session
//        let mockSession = MockURLSession()
//        let errorData = """
//         {
//             "error": "Invalid credentials"
//         }
//         """.data(using: .utf8)!
//        mockSession.data = errorData
//        mockSession.response = HTTPURLResponse(url: EndPoint.login.url()!,
//                                              statusCode: 400,
//                                              httpVersion: nil,
//                                              headerFields: nil)
//        apiManager.urlSession = mockSession
//        
//        let expectation = XCTestExpectation(description: "Login Failed")
//        apiManager.responseModel.sink { responseModel in
//            if let responseModel,responseModel.status == 400{
//                expectation.fulfill()
//            }
//        }.store(in: &cancellables)
//        
//        try await apiManager.request(endPoint: .login)
//        await fulfillment(of: [expectation])
//        
//    }
//    
//
//    func generateMockSession(endPoint: EndPoint) -> MockURLSession {
//        let mockSession = MockURLSession()
//        let data = mockSession.data
//        mockSession.response = HTTPURLResponse(url: endPoint.url()!,
//                                              statusCode: 200,
//                                              httpVersion: nil,
//                                              headerFields: nil)
//        return mockSession
//    }
//    
//}
//

// MockURLSession for testing
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}

// Test class for APIManager
class APIManagerTests: XCTestCase {
    var apiManager: APIManager!
    var mockURLSession: MockURLSession!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        apiManager = APIManager(urlSession: mockURLSession)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        apiManager = nil
        mockURLSession = nil
        cancellables = nil
        super.tearDown()
    }
    
    // Helper function to create a mock response
    func createResponse(statusCode: Int, url: URL) -> HTTPURLResponse {
        return HTTPURLResponse(url: url,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: nil)!
    }
    
    // Helper function to create mock data
    func createData() -> Data {
        return try! JSONEncoder().encode(ResponseModel(status: 200, error: nil))
    }
    
    // Test for successful request
    func testRequest_Success() async throws {
        // Arrange
        mockURLSession.data = createData()
        mockURLSession.response = createResponse(statusCode: 200,url: EndPoint.login.url()!)
        
        // Act
        try await apiManager.request(endPoint: .login)
        
        // Assert
        let expectation = XCTestExpectation(description: "Response received")
        apiManager.responseModel
            .sink { response in
                XCTAssertEqual(response?.status, 200)
                XCTAssertNil(response?.error)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    // Test for failure request
    func testRequest_Failure() async throws {
        // Arrange
        mockURLSession.data = createData()
        mockURLSession.response = createResponse(statusCode: 400,url: EndPoint.login.url()!)
        
        // Act
        try await apiManager.request(endPoint: .login)
        
        // Assert
        let expectation = XCTestExpectation(description: "Response received")
        apiManager.responseModel
            .sink { response in
                XCTAssertEqual(response?.status, 400)
                XCTAssertNotNil(response?.error)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1)
    }
    
}
