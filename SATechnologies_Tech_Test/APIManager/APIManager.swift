import Foundation
import Combine

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol{
    func data(for request: URLRequest) async throws -> (Data, URLResponse){
        try await data(for: request, delegate: nil)
    }
}

protocol APIManagerProtocol{
    func request<T:Encodable>(endPoint:EndPoint,userInput:T) async throws
}

class APIManager:APIManagerProtocol {
    
    public static var shared = APIManager()
    var responseModel = PassthroughSubject<ResponseModel?,Never>()
    var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared){
        self.urlSession = urlSession
    }

    func request<T:Encodable>(endPoint:EndPoint,userInput:T = EmptyInput()) async throws{

        guard let url = endPoint.url()  else {
            throw APIError.invalidUrl
        }
        
        let httpMethod = endPoint.getHTTPMethod()
        var request = URLRequest(url: url)
        
        if httpMethod == .post{
            let jsonData = try JSONEncoder().encode(userInput)
            request.httpBody = jsonData
        }
        
        request.httpMethod = endPoint.getHTTPMethod().rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await urlSession.data(for: request)
        try parseResponse(data: data, response: response,endPoint: endPoint)
    }
}
