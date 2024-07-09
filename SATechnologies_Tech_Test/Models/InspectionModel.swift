import Foundation

// Inspection Type Model
class InspectionType: Codable {
    let id: Int
    let name: String
    let access: String
}

// Area Model
class Area: Codable {
    let id: Int
    let name: String
}

// Answer Choice Model
class AnswerChoice: Codable {
    let id: Int
    let name: String
    let score: Double
}

// Question Model
class Question: Codable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    var selectedAnswerChoiceId: Int?
    var isExpanded : Bool = true
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case answerChoices
            case selectedAnswerChoiceId
        }
}

// Category Model
class Category: Codable {
    let id: Int
    let name: String
    var questions: [Question]
    var isExpanded : Bool = true
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case questions
        }
}

// Survey Model
class Survey: Codable {
    let id: Int
    var categories: [Category]
}

// Inspection  Model
class Inspection: Codable {
    let inspection: InspectionModel    
}


class InspectionModel:Codable{
    let id: Int
    let inspectionType: InspectionType
    let area: Area
    var survey: Survey
}
