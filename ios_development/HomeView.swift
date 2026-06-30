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
                Color(red: 0.95, green: 0.97, blue: 1.0)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    VStack(spacing: 8) {
                        
                             Text("Challenge")
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))

                        Text("Zone")
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.45, green: 0.65, blue: 0.95))

                        Text("A collection of Mini Games.")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                            .padding(.top, 4)
                    }

                    Spacer()

                    VStack(spacing: 14) {
                        NavigationLink {
                            TapFrenzyGameView()
                        } label: {
                            HStack(spacing: 10) {
                               
                                Text("Tap Frenzy Game")
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
                           LightItUpGameView()
                        } label: {
                            HStack(spacing: 10) {
                                
                                Text("Light It Up Game")
                                    .font(.system(size: 17, weight: .medium, design: .rounded))
                            }
                            .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
                            )
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
