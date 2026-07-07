//
//  HomeView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.09, green: 0.10, blue: 0.14)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 28) {
                        VStack(spacing: 6) {
                            Text("Challenge Zone")
                                .font(.title.bold())
                                .foregroundColor(.white)
                            Text("Pick a game and test your skills")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.top, 20)

                        VStack(spacing: 16) {
                            NavigationLink(destination: TapFrenzyGameView()) {
                                GameCard(
                                    title: "Tap Frenzy",
                                    subtitle: "Quick reflexes, big scores",
                                    icon: "bolt.fill",
                                    color: Color.purple
                                )
                            }

                            NavigationLink(destination: LightItUpGameView()) {
                                GameCard(
                                    title: "Light It Up",
                                    subtitle: "Match the pattern",
                                    icon: "lightbulb.fill",
                                    color: Color.teal
                                )
                            }

                            NavigationLink(destination: QuizGameView()) {
                                GameCard(
                                    title: "Quiz Game",
                                    subtitle: "How much do you know?",
                                    icon: "questionmark.circle.fill",
                                    color: Color.orange
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
       
               
           }
    
    
}





