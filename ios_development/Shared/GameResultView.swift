import SwiftUI
import SwiftData
internal import _LocationEssentials

struct GameResultView: View {
    let gameName: String
    let score: Int

    @Environment(\.modelContext) private var modelContext
    @Environment(LocationService.self) private var locationService
    @Environment(\.dismiss) private var dismiss
    @State private var didSave = false
    @State private var animateScore = false

    private var shareText: String {
        "I just scored \(score) on \(gameName) - can you beat it?"
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.accentColor.opacity(0.18), Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 8) {
                    Image(systemName: "flag.checkered")
                        .font(.system(size: 34))
                        .foregroundStyle(Color.accentColor)

                    Text("Game Over")
                        .font(.largeTitle.bold())
                }

                VStack(spacing: 10) {
                    Text(gameName.uppercased())
                        .font(.subheadline.weight(.semibold))
                        .tracking(1.2)
                        .foregroundStyle(.secondary)

                    Text("\(score)")
                        .font(.system(size: 72, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                        .scaleEffect(animateScore ? 1 : 0.6)
                        .opacity(animateScore ? 1 : 0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: animateScore)
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 36)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.thinMaterial)
                )
                .shadow(color: .black.opacity(0.08), radius: 12, y: 6)

                Spacer()

                VStack(spacing: 14) {
                    ShareLink(item: shareText) {
                        Label("Share Your Score", systemImage: "square.and.arrow.up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }

                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await saveSessionIfNeeded()
        }
        .onAppear {
            animateScore = true
        }
    }

    private func saveSessionIfNeeded() async {
        guard !didSave else { return }
        didSave = true

        let coordinate = await locationService.getCurrentLocation()

        let session = GameSession(
            gameName: gameName,
            score: score,
            latitude: coordinate?.latitude,
            longitude: coordinate?.longitude
        )
        modelContext.insert(session)
    }
}
