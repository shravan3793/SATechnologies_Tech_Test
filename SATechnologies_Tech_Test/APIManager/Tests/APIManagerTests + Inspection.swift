import Foundation
import XCTest
@testable import SATechnologies_Tech_Test

extension APIManagerTests{
    func testRequest_InspectionEndPoint_Success() async throws{
        //mock session and data
        apiManager.urlSession = getMockSessionForInspectionSuccess()
        
        //set expectation
        let expectation = XCTestExpectation(description: "Inspection Start Data Fetched")
        
        try await apiManager.request(endPoint: .startInspection)
        
        if DataManager.shared.inspectionData != nil{
            expectation.fulfill()
        }

        await fulfillment(of: [expectation],timeout: 5)
        
    }
    
    
    func getMockSessionForInspectionSuccess() -> MockURLSession{
        let mockSession = MockURLSession()
        let data = mockData().data(using: .utf8)!
        mockSession.data = data
        mockSession.response = HTTPURLResponse(url: EndPoint.startInspection.url()!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        return mockSession
    }
    
}

 func mockData() -> String{
    return
            """
            {
                "inspection": {
                    "area": {
                        "id": 1,
                        "name": "Emergency ICU"
                    },
                    "id": 1,
                    "inspectionType": {
                        "access": "write",
                        "id": 1,
                        "name": "Clinical"
                    },
                    "survey": {
                        "categories": [
                            {
                                "id": 1,
                                "name": "Drugs",
                                "questions": [
                                    {
                                        "answerChoices": [
                                            {
                                                "id": 1,
                                                "name": "Yes",
                                                "score": 1.0
                                            },
                                            {
                                                "id": 2,
                                                "name": "No",
                                                "score": 0.0
                                            },
                                            {
                                                "id": -1,
                                                "name": "N/A",
                                                "score": 0.0
                                            }
                                        ],
                                        "id": 1,
                                        "name": "Is the drugs trolley locked?",
                                        "selectedAnswerChoiceId": null
                                    },
                                    {
                                        "answerChoices": [
                                            {
                                                "id": 3,
                                                "name": "Everyday",
                                                "score": 1.0
                                            },
                                            {
                                                "id": 4,
                                                "name": "Every two days",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 5,
                                                "name": "Every week",
                                                "score": 0.0
                                            }
                                        ],
                                        "id": 2,
                                        "name": "How often is the floor cleaned?",
                                        "selectedAnswerChoiceId": null
                                    }
                                ]
                            },
                            {
                                "id": 2,
                                "name": "Overall Impressions",
                                "questions": [
                                    {
                                        "answerChoices": [
                                            {
                                                "id": 6,
                                                "name": "1-2",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 7,
                                                "name": "3-6",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 8,
                                                "name": "6+",
                                                "score": 0.5
                                            },
                                            {
                                                "id": -1,
                                                "name": "N/A",
                                                "score": 0.0
                                            }
                                        ],
                                        "id": 3,
                                        "name": "How many staff members are present in the ward?",
                                        "selectedAnswerChoiceId": null
                                    },
                                    {
                                        "answerChoices": [
                                            {
                                                "id": 9,
                                                "name": "Very often",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 10,
                                                "name": "Often",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 11,
                                                "name": "Not very often",
                                                "score": 0.5
                                            },
                                            {
                                                "id": 12,
                                                "name": "Never",
                                                "score": 0.5
                                            }
                                        ],
                                        "id": 4,
                                        "name": "How often are the area inspections carried?",
                                        "selectedAnswerChoiceId": null
                                    }
                                ]
                            }
                        ],
                        "id": 1
                    }
                }
            }
    """
}
