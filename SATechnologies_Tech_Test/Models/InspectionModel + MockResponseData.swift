
import Foundation
fileprivate let mockJsonData = """
{
    "inspection": {
        "area": {
            "id": 1,
            "name": "Emergency ICU"
        },
        "id": 84,
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
                                    "score": 1
                                },
                                {
                                    "id": 2,
                                    "name": "No",
                                    "score": 0
                                },
                                {
                                    "id": -1,
                                    "name": "N/A",
                                    "score": 0
                                }
                            ],
                            "id": 1,
                            "name": "Is the drugs trolley locked?",
                            "selectedAnswerChoiceId": 1
                        },
                        {
                            "answerChoices": [
                                {
                                    "id": 3,
                                    "name": "Everyday",
                                    "score": 1
                                },
                                {
                                    "id": 4,
                                    "name": "Every two days",
                                    "score": 0.5
                                },
                                {
                                    "id": 5,
                                    "name": "Every week",
                                    "score": 0
                                }
                            ],
                            "id": 2,
                            "name": "How often is the floor cleaned?",
                            "selectedAnswerChoiceId": 3
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
                                    "score": 0
                                }
                            ],
                            "id": 3,
                            "name": "How many staff members are present in the ward?",
                            "selectedAnswerChoiceId": 8
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
                            "selectedAnswerChoiceId": 9
                        }
                    ]
                }
            ],
            "id": 1
        }
    }
}
"""

func getMockJsonData() -> Inspection?{
    
    do{
        let encodedData = Data(mockJsonData.utf8)
        let data = try JSONDecoder().decode(Inspection.self, from: encodedData)
        return data
    }catch{
        print(error)
    }
    return nil
}
