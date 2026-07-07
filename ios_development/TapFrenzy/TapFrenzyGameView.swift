import SwiftUI
import Combine

struct TapFrenzyGameView: View {

    @State private var score = 0
    @State private var timeLeft = 10
    @State private var buttonColor: Color = .blue
    @State private var isPlaying = false
    @State private var gameOver = false
    @State private var lastTapScale: CGFloat = 1.0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        if gameOver {
            TapFrenzyGameOverView(
                score: score,
                playAgain: resetGame
            )
        } else {
            ZStack {
                LinearGradient(
                    colors: [buttonColor.opacity(0.25), Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.6), value: buttonColor)

                VStack(spacing: 32) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("SCORE")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(score)")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .contentTransition(.numericText())
                                .animation(.snappy, value: score)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text("TIME")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(timeLeft)")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(timeLeft <= 3 ? .red : .primary)
                        }
                    }
                    .padding(.horizontal, 24)

                  
                    ProgressView(value: Double(timeLeft), total: 10)
                        .tint(timeLeft <= 3 ? .red : buttonColor)
                        .padding(.horizontal, 24)

                    Spacer()

                    Button(action: handleTap) {
                        Text(isPlaying ? "TAP!" : "START")
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .frame(width: 220, height: 220)
                            .background(
                                Circle()
                                    .fill(buttonColor.gradient)
                                    .shadow(color: buttonColor.opacity(0.5), radius: 15, y: 8)
                            )
                            .scaleEffect(buttonScale())
                            .foregroundColor(.white)
                    }
                    .scaleEffect(lastTapScale)
                    .buttonStyle(.plain)

                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .onReceive(timer) { _ in
                guard isPlaying, timeLeft > 0 else { return }
                timeLeft -= 1
                if timeLeft == 0 {
                    isPlaying = false
                    gameOver = true
                }
            }
            .onReceive(colorTimer) { _ in
                if isPlaying { changeColor() }
            }
        }
    }

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
    
    
    func buttonScale() -> CGFloat {
            let maxScale: CGFloat = 1.2
            let minScale: CGFloat = 0.3

            let progress = Double(timeLeft) / 10.0

            return minScale + (maxScale - minScale) * progress
    }

    func changeColor() {
        let colors: [Color] = [.blue, .green, .purple, .orange, .pink]
        withAnimation(.easeInOut(duration: 0.5)) {
            buttonColor = colors.randomElement()!
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

#Preview {
    TapFrenzyGameView()
}

