//
//  Question.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import Foundation

struct QuizService {

    private let url =
    URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!

    func fetchQuestions() async throws -> [Question] {

        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try JSONDecoder().decode(QuizResponse.self, from: data)

        return response.results
    }
}
