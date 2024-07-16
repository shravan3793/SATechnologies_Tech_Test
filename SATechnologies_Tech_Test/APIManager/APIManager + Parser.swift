import Foundation
extension APIManager{
    func parseResponse(data: Data,response:URLResponse,endPoint:EndPoint) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        let statusCode = httpResponse.statusCode
        
        if statusCode != 200 && (endPoint == .login || endPoint == .register){
            let responseData = try JSONDecoder().decode(ResponseModel.self, from: data)
            responseModel.send(ResponseModel(status: statusCode, error: responseData.error))
        }else if statusCode == 200 && (endPoint == .login || endPoint == .register){
            responseModel.send(ResponseModel(status: statusCode, error: nil))
        }else if endPoint == .startInspection{
            let responseData = try JSONDecoder().decode(Inspection.self, from: data)
            DataManager.shared.inspectionData = responseData
        }else{
            responseModel.send(ResponseModel(status: statusCode, error: nil))  
        }
    }
}
