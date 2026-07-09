//
//  LightItUpVM.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import Combine

struct Card: Identifiable {
    let id = UUID()
    var isLit = false
}

struct Level {
    let cardCount: Int
    let columns: Int
    let litWindow: Double
    let litCards: Int
}

final class LightItUpVM: ObservableObject {

    @Published var score = 0
    @Published var timeLeft = 60
    @Published var gameOver = false
    @Published var isPlaying = false
    @Published var cards: [Card] = []
    @Published var showLevelUp = false
    @Published var displayedLevel = 1

    @AppStorage("lighttap_top_scores")
    private var savedScores = ""

    var bestScore: Int {
        savedScores
            .split(separator: ",")
            .compactMap { Int($0) }
            .max() ?? 0
    }

    var currentLevel: Level {
        let elapsed = 60 - timeLeft

        switch elapsed {
        case 0..<15:
            return Level(cardCount: 3, columns: 3, litWindow: 1.5, litCards: 1)

        case 15..<30:
            return Level(cardCount: 4, columns: 2, litWindow: 1.2, litCards: 1)

        case 30..<45:
            return Level(cardCount: 6, columns: 3, litWindow: 1.0, litCards: 1)

        default:
            return Level(cardCount: 9, columns: 3, litWindow: 0.8, litCards: 2)
        }
    }

    var levelName: String {
        let elapsed = 60 - timeLeft

        switch elapsed {
        case 0..<15: return "Level 1"
        case 15..<30: return "Level 2"
        case 30..<45: return "Level 3"
        default: return "Level 4"
        }
    }

    var levelColor: Color {
        let elapsed = 60 - timeLeft

        switch elapsed {
        case 0..<15:
            return .blue
        case 15..<30:
            return .green
        case 30..<45:
            return .orange
        default:
            return .purple
        }
    }

    init() {
        setupCards()
        lightRandomCards()
    }

    func setupCards() {
        cards = (0..<currentLevel.cardCount).map { _ in
            Card(isLit: false)
        }
    }

    func updateCards() {
        if cards.count != currentLevel.cardCount {
            cards = (0..<currentLevel.cardCount).map { _ in
                Card()
            }
        }
    }

    func lightRandomCards() {

        for i in cards.indices {
            cards[i].isLit = false
        }

        let indices = cards.indices.shuffled()

        for i in indices.prefix(currentLevel.litCards) {
            cards[i].isLit = true
        }
    }

    func handleTap(_ card: Card) {

        guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }

        if cards[index].isLit {

            let elapsed = 60 - timeLeft

            if elapsed >= 45 {
                score += 5
            } else {
                score += 1
            }

            cards[index].isLit = false

        } else {
            score -= 1
        }

        if !isPlaying {
            isPlaying = true
        }
    }

    func tick() {

        guard timeLeft > 0 else {
            endGame()
            return
        }

        guard isPlaying else { return }

        timeLeft -= 1

        checkLevelUp()
        updateCards()
        lightRandomCards()
    }

    func checkLevelUp() {

        let elapsed = 60 - timeLeft
        let newLevel: Int

        switch elapsed {
        case 0..<15:
            newLevel = 1
        case 15..<30:
            newLevel = 2
        case 30..<45:
            newLevel = 3
        default:
            newLevel = 4
        }

        if newLevel > displayedLevel {

            displayedLevel = newLevel

            withAnimation(.spring()) {
                showLevelUp = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.showLevelUp = false
                }
            }
        }
    }

    func saveScore() {

        var scores = savedScores
            .split(separator: ",")
            .compactMap { Int($0) }

        scores.append(score)
        scores.sort(by: >)
        scores = Array(scores.prefix(5))

        savedScores = scores
            .map(String.init)
            .joined(separator: ",")
    }

    func endGame() {
        saveScore()
        gameOver = true
    }

    func resetGame() {
        score = 0
        timeLeft = 60
        isPlaying = false
        gameOver = false
        displayedLevel = 1
        showLevelUp = false

        setupCards()
        lightRandomCards()
    }
}
