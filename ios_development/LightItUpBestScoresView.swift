//
//  BestScoresView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI

struct LightItUpBestScoresView: View {
    @AppStorage("lighttap_top_scores")
    private var savedScores = ""

    var topScores: [Int] {
        savedScores
            .split(separator: ",")
            .compactMap { Int($0) }
    }

    
    

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack(spacing: 6) {
                    ZStack {
                       
                    }
                    .padding(.bottom, 8)

                    Text("Top 5 Scores")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))

                  
                }
                .padding(.top, 32)
                .padding(.bottom, 28)

                
                if topScores.isEmpty {
                    Spacer()
                    VStack(spacing: 10) {
                        Image(systemName: "gamecontroller")
                            .font(.system(size: 40))
                            .foregroundColor(Color(red: 0.75, green: 0.80, blue: 0.90))
                        Text("No scores yet")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(Color(red: 0.65, green: 0.70, blue: 0.78))
                        Text("Play a game to see your best here")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(Color(red: 0.75, green: 0.78, blue: 0.85))
                    }
                    Spacer()
                } else {
                    VStack(spacing: 10) {
                        ForEach(Array(topScores.enumerated()), id: \.offset) { index, score in
                            HStack(spacing: 14) {

                                
                                ZStack {
                                   
                                }

                                
                                Text("\(index + 1)")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                                    .frame(width: 30, alignment: .leading)

                                Spacer()

                                
                                Text("\(score)")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(
                                        index == 0
                                        ? Color(red: 0.75, green: 0.50, blue: 0.05)
                                        : Color(red: 0.15, green: 0.20, blue: 0.35)
                                    )

                                
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        index == 0
                                        ? Color(red: 1.00, green: 0.80, blue: 0.20).opacity(0.50)
                                        : Color(red: 0.88, green: 0.91, blue: 0.97),
                                        lineWidth: index == 0 ? 1.5 : 1
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
