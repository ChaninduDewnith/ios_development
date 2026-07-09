//
//  StatsTab.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query(sort: \GameSession.date, order: .reverse) private var sessions: [GameSession]

    private var gameNames: [String] {
        Array(Set(sessions.map { $0.gameName })).sorted()
    }

    private func bestScore(for game: String) -> Int {
        sessions.filter { $0.gameName == game }.map { $0.score }.max() ?? 0
    }

    private func averageScore(for game: String) -> Double {
        let scores = sessions.filter { $0.gameName == game }.map { $0.score }
        guard !scores.isEmpty else { return 0 }
        return Double(scores.reduce(0, +)) / Double(scores.count)
    }

    var body: some View {
        List {
            Section("Overview") {
                LabeledContent("Total games played", value: "\(sessions.count)")
                LabeledContent("Total score", value: "\(sessions.reduce(0) { $0 + $1.score })")
            }

            if !sessions.isEmpty {
                Section("Best Scores") {
                    ForEach(gameNames, id: \.self) { game in
                        LabeledContent(game, value: "\(bestScore(for: game))")
                    }
                }

                Section("Average score by game") {
                    Chart {
                        ForEach(gameNames, id: \.self) { game in
                            BarMark(
                                x: .value("Game", game),
                                y: .value("Average score", averageScore(for: game))
                            )
                            .foregroundStyle(by: .value("Game", game))
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
                } else {
                    ForEach(sessions.prefix(10)) { session in
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
                        }
                    }
                }
            }
        }
        .navigationTitle("Stats")
    }
}


