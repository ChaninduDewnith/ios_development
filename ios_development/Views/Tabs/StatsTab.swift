import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query(sort: \GameSession.date, order: .reverse) private var sessions: [GameSession]

    private var viewModel: StatsViewModel {
        StatsViewModel(sessions: sessions)
    }

    var body: some View {
        List {
            Section("Overview") {
                LabeledContent {
                    Text("\(viewModel.totalGamesPlayed)")
                } label: {
                    Label("Total games played", systemImage: "gamecontroller.fill")
                }

                LabeledContent {
                    Text("\(viewModel.totalScore)")
                } label: {
                    Label("Total score", systemImage: "star.fill")
                }
            }

            if !sessions.isEmpty {
                Section("Best Scores") {
                    ForEach(viewModel.gameNames, id: \.self) { game in
                        LabeledContent {
                            Text("\(viewModel.bestScore(for: game))")
                                .fontWeight(.bold)
                        } label: {
                            Label(game, systemImage: "trophy.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }

                Section("Average score by game") {
                    Chart {
                        ForEach(viewModel.gameNames, id: \.self) { game in
                            BarMark(
                                x: .value("Game", game),
                                y: .value("Average score", viewModel.averageScore(for: game))
                            )
                            .foregroundStyle(by: .value("Game", game))
                            .cornerRadius(6)
                        }
                    }
                    .frame(height: 220)
                    .padding(.vertical, 8)
                }
            }

            Section("Recent games") {
                if sessions.isEmpty {
                    Text("No games played yet. Go play something!")
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 8)
                } else {
                    ForEach(viewModel.recentSessions) { session in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(session.gameName)
                                    .font(.headline)
                                Text(session.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(session.score)")
                                .font(.title3.bold())
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Stats")
    }
}
