//
//  TapFrenzyVM.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import Combine

class TapFrenzyVM: ObservableObject {

    @Published var score = 0
    @Published var timeLeft = 10
    @Published var buttonColor: Color = .blue
    @Published var isPlaying = false
    @Published var gameOver = false
    @Published var lastTapScale: CGFloat = 1.0

    func handleTap() {
        if !isPlaying {
            isPlaying = true
        }

        score += 1

        withAnimation(.easeOut(duration: 0.08)) {
            lastTapScale = 0.9
        }

        withAnimation(.spring(response: 0.3, dampingFraction: 0.4).delay(0.08)) {
            lastTapScale = 1.0
        }
    }

    func updateTimer() {
        guard isPlaying, timeLeft > 0 else { return }

        timeLeft -= 1

        if timeLeft == 0 {
            isPlaying = false
            gameOver = true
        }
    }

    func buttonScale() -> CGFloat {
        let maxScale: CGFloat = 1.2
        let minScale: CGFloat = 0.3

        let progress = Double(timeLeft) / 10.0

        return minScale + (maxScale - minScale) * CGFloat(progress)
    }

    func changeColor() {
        let colors: [Color] = [.blue, .green, .purple, .orange, .pink]

        withAnimation(.easeInOut(duration: 0.5)) {
            buttonColor = colors.randomElement() ?? .blue
        }
    }

    func resetGame() {
        score = 0
        timeLeft = 10
        isPlaying = false
        gameOver = false
        buttonColor = .blue
        lastTapScale = 1.0
    }
}


