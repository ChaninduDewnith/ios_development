//
//  LightItUpGameOverView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI

struct LightItUpGameOverView: View {
    let score: Int
    let bestScore: Int
    let playAgain: () -> Void

    var isNewBest: Bool { score >= bestScore && score > 0 }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.95, green: 0.97, blue: 1.0)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    
                    ZStack {
                        
                    }
                    .padding(.bottom, 24)

                    
                    Text("Game Over")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))

                    if isNewBest {
                        Text("New best score!")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                            .padding(.top, 6)
                    }

                    
                    HStack(spacing: 12) {
                        VStack(spacing: 4) {
                            Text("Your score")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                            Text("\(score)")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.88, green: 0.91, blue: 0.97), lineWidth: 1)
                        )

                        VStack(spacing: 4) {
                            Text("Best")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                            Text("\(bestScore)")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color(red: 0.40, green: 0.62, blue: 0.95).opacity(0.08))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.40, green: 0.62, blue: 0.95).opacity(0.20), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 28)

                    Spacer()

                    
                    VStack(spacing: 12) {
                        Button(action: playAgain) {
                            HStack(spacing: 8) {
                                
                                    
                                Text("Play Again")
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 0.40, green: 0.62, blue: 0.95))
                            )
                        }

                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 8) {
                                
                                Text("View Best Scores")
                                    .font(.system(size: 17, weight: .medium, design: .rounded))
                            }
                            .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 0.88, green: 0.91, blue: 0.97), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 48)
                }
            }
            .navigationBarHidden(true)
        }
    }
}



