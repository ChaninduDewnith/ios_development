//
//  HomeView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI

struct HomeView: View {
    private var games: [GameItem] {
        [
            GameItem(
                title: "Tap Frenzy",
                icon: "rectangle.stack.fill",
                tint: Color(red: 0.23, green: 0.20, blue: 0.54),
                bgTint: Color(red: 0.81, green: 0.80, blue: 0.96),
                cardTint: Color(red: 0.91, green: 0.90, blue: 0.98),
                destination: AnyView(TapFrenzyGameView())
            ),
            GameItem(
                title: "Light It Up",
                icon: "rectangle.stack.fill",
                tint: Color(red: 0.03, green: 0.31, blue: 0.25),
                bgTint: Color(red: 0.62, green: 0.88, blue: 0.79),
                cardTint: Color(red: 0.87, green: 0.96, blue: 0.92),
                destination: AnyView(LightItUpGameView())
            ),
            GameItem(
                title: "Quiz Game",
                icon: "questionmark.circle.fill",
                tint: Color(red: 0.44, green: 0.17, blue: 0.07),
                bgTint: Color(red: 0.94, green: 0.60, blue: 0.48),
                cardTint: Color(red: 0.98, green: 0.90, blue: 0.86),
                destination: AnyView(QuizGameView())
            )
        ]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.23, green: 0.24, blue: 0.27)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 28) {
                        VStack(spacing: 6) {
                            Text("Challenge zone")
                                .font(.title2.weight(.medium))
                                .foregroundColor(.white)
                            Text("Pick a game and test your skills")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.65))
                        }
                        .padding(.top, 20)
                        VStack(spacing: 20) {
                            ForEach(games) { game in
                                NavigationLink(destination: game.destination) {
                                    GameCard(game: game)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}
