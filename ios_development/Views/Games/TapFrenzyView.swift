//
//  TapFrenzyView.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import Combine

struct TapFrenzyView: View {

    @StateObject private var vm = TapFrenzyVM()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {

        if vm.gameOver {

            GameResultView(
                  gameName: "Tap Frenzy",
                  score: vm.score,
                  
            )

        } else {

            ZStack {

                LinearGradient(
                    colors: [
                        vm.buttonColor.opacity(0.25),
                        Color(.systemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.6), value: vm.buttonColor)

                VStack(spacing: 32) {

                    HStack {

                        VStack(alignment: .leading, spacing: 4) {

                            Text("SCORE")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("\(vm.score)")
                                .font(.system(size: 40,
                                              weight: .bold,
                                              design: .rounded))
                                .contentTransition(.numericText())
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {

                            Text("TIME")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("\(vm.timeLeft)")
                                .font(.system(size: 40,
                                              weight: .bold,
                                              design: .rounded))
                                .foregroundColor(
                                    vm.timeLeft <= 3 ? .red : .primary
                                )
                        }
                    }
                    .padding(.horizontal, 24)

                    ProgressView(
                        value: Double(vm.timeLeft),
                        total: 10
                    )
                    .tint(vm.timeLeft <= 3 ? .red : vm.buttonColor)
                    .padding(.horizontal, 24)

                    Spacer()

                    Button(action: vm.handleTap) {

                        Text(vm.isPlaying ? "TAP!" : "START")
                            .font(.system(size: 28,
                                          weight: .heavy,
                                          design: .rounded))
                            .frame(width: 220, height: 220)
                            .background(
                                Circle()
                                    .fill(vm.buttonColor.gradient)
                                    .shadow(
                                        color: vm.buttonColor.opacity(0.5),
                                        radius: 15,
                                        y: 8
                                    )
                            )
                            .foregroundColor(.white)
                            .scaleEffect(vm.buttonScale())
                    }
                    .buttonStyle(.plain)
                    .scaleEffect(vm.lastTapScale)

                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .onReceive(timer) { _ in
                vm.updateTimer()
            }
            .onReceive(colorTimer) { _ in
                if vm.isPlaying {
                    vm.changeColor()
                }
            }
        }
    }
}


