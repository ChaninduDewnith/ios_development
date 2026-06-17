//
//  GameOverView.swift
//  ios_development
//
//  Created by student2 on 2026-06-11.
//

import SwiftUI

struct GameOverView: View {

    let score: Int
    let playAgain: () -> Void


    var body: some View {

        VStack(spacing: 30) {

            Text("Game Over")
                .font(.largeTitle)
                .foregroundColor(.red)

            Text("Final Score: \(score)")
                .font(.title)

            Button("Play Again") {
                playAgain()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    GameOverView(score: 0,playAgain: {})
}
