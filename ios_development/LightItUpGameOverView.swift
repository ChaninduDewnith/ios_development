//
//  LightItUpGameOverView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI

struct LightItUpGameOverView: View {
    
    

   

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.95, green: 0.97, blue: 1.0)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.40, green: 0.62, blue: 0.95).opacity(0.10))
                            .frame(width: 90, height: 90)
                       
                    }
                    .padding(.bottom, 24)

                    
                    Text("Game Over")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))

                   

                    
                    HStack(spacing: 12) {
                        VStack(spacing: 4) {
                            Text("Your score")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                            Text("Score")
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
                            Text("bestScore")
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



#Preview {
    LightItUpGameOverView()
}
