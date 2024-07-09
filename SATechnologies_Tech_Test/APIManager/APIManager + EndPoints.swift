import Foundation

enum EndPoint: String{
    case register = "/api/register"
    case login = "/api/login"
    case startInspection = "/api/inspections/start"
    case submitInspection = "/api/inspections/submit"
    
    func getHTTPMethod() -> HttpMethod{
        switch self{
        case .register,
                .login,
                .submitInspection:
            return .post
        case .startInspection:
            return .get

        }
    }
}

enum HttpMethod:String{
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

enum APIError : Error{
    case invalidUrl
    case unknownError
    
}


