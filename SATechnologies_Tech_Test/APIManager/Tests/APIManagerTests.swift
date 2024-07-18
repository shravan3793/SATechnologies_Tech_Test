import XCTest
import Combine

@testable import SATechnologies_Tech_Test

final class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    var cancellables : Set<AnyCancellable>!

    override func setUpWithError() throws {
        apiManager = APIManager()
        cancellables = []
    }

    override func tearDownWithError() throws {
        apiManager = nil
        cancellables = nil
    }
    
    func testRequest_LoginEndPoint_Success() async throws{

        //1. generate mock session
        apiManager.urlSession = generateMockSession(endPoint: .login)
        
        //2. set expectations
        let expectation = XCTestExpectation(description: "Fetches Data Successfully")
        
        //3. verify expectations
        apiManager.responseModel.sink { responseModel in
            if let responseModel,
               responseModel.status == 200{
                XCTAssertNil(responseModel.error)
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        try await apiManager.request(endPoint: .login)
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testRequest_LoginEndPoint_Failure() async throws{
        //1. generate mock session
        let mockSession = URLSessionMock()
        let errorData = """
         {
             "error": "Invalid credentials"
         }
         """.data(using: .utf8)!
        mockSession.data = errorData
        mockSession.response = HTTPURLResponse(url: EndPoint.login.url()!,
                                              statusCode: 400,
                                              httpVersion: nil,
                                              headerFields: nil)
        apiManager.urlSession = mockSession
        
        let expectation = XCTestExpectation(description: "Login Failed")
        apiManager.responseModel.sink { responseModel in
            if let responseModel,responseModel.status == 400{
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        try await apiManager.request(endPoint: .login)
        await fulfillment(of: [expectation])
        
    }
    

    func generateMockSession(endPoint: EndPoint) -> URLSessionMock {
        let mockSession = URLSessionMock()
        let data = mockSession.data
        mockSession.response = HTTPURLResponse(url: endPoint.url()!,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)
        return mockSession
    }
    
}

class URLSessionMock: URLSessionProtocol{
    var data : Data?
    var response: URLResponse?
    var error: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error{
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
