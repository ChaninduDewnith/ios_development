//
//  GameOverView.swift
//  ios_development
//
//  Created by student2 on 2026-06-11.
//

import SwiftUI

struct TapFrenzyGameOverView: View {
    let score: Int
    let playAgain: () -> Void

    @State private var appear = false

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "flag.checkered")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                    .scaleEffect(appear ? 1 : 0.5)
                    .opacity(appear ? 1 : 0)

                Text("Game Over")
                    .font(.system(size: 34, weight: .bold, design: .rounded))

                VStack(spacing: 4) {
                    Text("FINAL SCORE")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .tracking(1.5)

                    Text("\(score)")
                        .font(.system(size: 64, weight: .heavy, design: .rounded))
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 12)

                

                Button(action: playAgain) {
                    Text("Play Again")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue.gradient)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 40)
                .padding(.top, 12)
            }
            .padding()
            .opacity(appear ? 1 : 0)
            .offset(y: appear ? 0 : 20)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                appear = true
            }
        }
    }

    
    
}


