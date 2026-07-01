//
//  Question.swift
//  ios_development
//
//  Created by student2 on 2026-07-01.
//

import Foundation

struct QuizResponse: Codable {
    let results: [Question]
}

struct Question: Codable, Identifiable {

    let id = UUID()

    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]

    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correct_answer
        case incorrect_answers
    }

    var allAnswers: [String] {
        (incorrect_answers + [correct_answer])
    }
}
