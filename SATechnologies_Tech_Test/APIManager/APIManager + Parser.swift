import Foundation

extension APIManager {
    func parseResponse(data: Data, response: URLResponse, endPoint: EndPoint) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        let statusCode = httpResponse.statusCode
        
        switch (statusCode, endPoint) {
        case (200, .login), (200, .register):
            responseModel = ResponseModel(status: statusCode, error: nil)
            
        case (_, .login), (_, .register):
            let responseData = try JSONDecoder().decode(ResponseModel.self, from: data)
            responseModel = ResponseModel(status: statusCode, error: responseData.error)
            
        case (_, .startInspection):
            let responseData = try JSONDecoder().decode(Inspection.self, from: data)
            DataManager.shared.inspectionData = responseData
            
        default:
            responseModel = ResponseModel(status: statusCode, error: nil)
        }
    }
}
