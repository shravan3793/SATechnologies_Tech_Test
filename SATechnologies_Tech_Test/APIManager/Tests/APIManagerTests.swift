import XCTest
import Combine

@testable import SATechnologies_Tech_Test
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
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }
    
    func createResponse(statusCode: Int, url: URL) -> HTTPURLResponse {
        return HTTPURLResponse(url: url,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: nil)!
    }
    
    func createData() -> Data {
        return try! JSONEncoder().encode(ResponseModel(status: 200, error: nil))
    }
    
    func testRequest_Success() async throws {

        mockURLSession.response = createResponse(statusCode: 200,url: EndPoint.login.url()!)

        let expectation = XCTestExpectation(description: "Response received")
        apiManager.responseModel
            .sink { response in
                print("Received response: \(String(describing: response))")
                if let status = response?.status{
                    XCTAssertEqual(status, 200)
                    expectation.fulfill()
                }
                
            }.store(in: &cancellables)
        try await apiManager.request(endPoint: .login)

        await fulfillment(of: [expectation], timeout: 1)
    }
    

    func testRequest_Failure() async throws {
        mockURLSession.data = createData()
        mockURLSession.response = createResponse(statusCode: 400,url: EndPoint.login.url()!)

        let expectation = XCTestExpectation(description: "Response received")
        apiManager.responseModel
            .sink { response in
                XCTAssertEqual(response?.status, 400)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        try await apiManager.request(endPoint: .login)
        await fulfillment(of: [expectation], timeout: 1)
    }
    
}
