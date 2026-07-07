import SwiftUI

struct ResultView: View {
    let score: Int
    @Binding var showResult: Bool
    var onRestart: () -> Void = {}

    private var percentage: Double {
        Double(score) / 10.0
    }

    private var message: String {
        switch score {
        case 9...10: return "Outstanding!"
        case 7...8: return "Great job!"
        case 5...6: return "Nice effort!"
        default: return "Keep practicing!"
        }
    }

    private var icon: String {
        switch score {
        case 9...10: return "trophy.fill"
        case 7...8: return "star.fill"
        case 5...6: return "hand.thumbsup.fill"
        default: return "flame.fill"
        }
    }

    private var ringColor: Color {
        switch score {
        case 8...10: return Color.green
        case 5...7: return Color.orange
        default: return Color.red
        }
    }

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color(red: 0.23, green: 0.24, blue: 0.27),
                    Color(red: 0.12, green: 0.13, blue: 0.18)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()


            VStack(spacing: 28) {

                Spacer()


                VStack(spacing: 15) {

                    ZStack {

                        Circle()
                            .fill(ringColor.opacity(0.2))
                            .frame(width: 110, height: 110)

                        Image(systemName: icon)
                            .font(.system(size: 45))
                            .foregroundColor(ringColor)
                    }


                    Text("Quiz Finished")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)


                    Text(message)
                        .font(.title3.weight(.medium))
                        .foregroundColor(ringColor)

                }


                ZStack {

                    Circle()
                        .stroke(
                            Color.white.opacity(0.15),
                            lineWidth: 16
                        )


                    Circle()
                        .trim(from: 0, to: percentage)
                        .stroke(
                            ringColor,
                            style: StrokeStyle(
                                lineWidth: 16,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(
                            .easeOut(duration: 1),
                            value: percentage
                        )


                    VStack(spacing: 5) {

                        Text("\(score)")
                            .font(.system(size: 65, weight: .bold))
                            .foregroundColor(.white)

                        Text("out of 10")
                            .foregroundColor(.white.opacity(0.7))
                    }

                }
                .frame(width: 220, height: 220)


                Spacer()


                Button {

                    onRestart()

                } label: {

                    HStack {

                        Image(systemName: "arrow.clockwise")

                        Text("Play Again")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 0.23, green: 0.20, blue: 0.54),
                                Color(red: 0.45, green: 0.35, blue: 0.85)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 18)
                    )
                    .shadow(radius: 10)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)

            }
            .padding()

        }
    }
}
