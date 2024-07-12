import Foundation

class APIManager{
    
    public static var shared = APIManager()
    @Published var responseModel : ResponseModel? =  ResponseModel(status: 0, error: nil)

    func request<T:Encodable>(endPoint:EndPoint,userInput:T = EmptyInput()) async throws{
        let baseURL = "http://localhost:5001"
        guard let url = URL(string: baseURL + endPoint.rawValue) else {
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
        
        let (data,response) = try await URLSession.shared.data(for: request)
        try parseResponse(data: data, response: response,endPoint: endPoint)
        
    }

}




