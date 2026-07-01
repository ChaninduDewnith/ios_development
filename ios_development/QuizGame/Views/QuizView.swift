//
//  QuizView.swift
//  ios_development
//
//  Created by student2 on 2026-07-01.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class QuizView: ObservableObject {

    enum ViewState {
        case loading
        case loaded
        case failed
    }

    @Published var questions: [Question] = []
    @Published var index = 0
    @Published var score = 0
    @Published var streak = 0

    @Published var state: ViewState = .loading

    @Published var selectedAnswer: String?

    private let service = QuizService()

    func load() async {

        state = .loading

        do {

            questions = try await service.fetchQuestions()

            index = 0
            score = 0
            streak = 0

            state = .loaded

        } catch {

            state = .failed

        }
    }

    var currentQuestion: Question {
        questions[index]
    }

    var isFinished: Bool {
        index >= questions.count
    }

    func answerTapped(_ answer: String) {

        selectedAnswer = answer

        if answer == currentQuestion.correct_answer {

            score += 1
            streak += 1

        } else {

            streak = 0

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {

            self.selectedAnswer = nil

            self.index += 1

        }
    }
    
    
    
}



