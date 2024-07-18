import Foundation

//Authentication Model
struct AuthenticationModel:Codable{
    let email:String
    let password: String
}

// Response Model (also being used to handle Error response)
struct ResponseModel: Codable{
    var status: Int?
    var error:String?
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}

struct EmptyInput: Encodable {}
