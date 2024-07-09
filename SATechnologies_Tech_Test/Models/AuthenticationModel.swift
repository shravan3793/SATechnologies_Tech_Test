import Foundation

//Authentication Model
struct AuthenticationModel:Codable{
    let email:String
    let password: String
}

// Error Model (also being used to handle overall response)
struct ResponseModel: Decodable{
    var status: Int?
    var error:String?
}

struct EmptyInput: Encodable {}
