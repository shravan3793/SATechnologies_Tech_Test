import Foundation

// Inspection Type Model
struct InspectionType: Codable {
    let id: Int
    let name: String
    let access: String
}

// Area Model
struct Area: Codable {
    let id: Int
    let name: String
}

// Answer Choice Model
struct AnswerChoice: Codable {
    let id: Int
    let name: String
    let score: Double
}

// Question Model
struct Question: Codable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    let selectedAnswerChoiceId: Int?
}

// Category Model
struct Category: Codable {
    let id: Int
    let name: String
    let questions: [Question]
}

// Survey Model
struct Survey: Codable {
    let id: Int
    let categories: [Category]
}

// Inspection Model
struct Inspection: Codable {
    let inspection: InspectionModel    
}

struct InspectionModel:Codable{
    let id: Int
    let inspectionType: InspectionType
    let area: Area
    let survey: Survey
}
