import Foundation

struct StatsViewModel {
    let sessions: [GameSession]

    var gameNames: [String] {
        Array(Set(sessions.map { $0.gameName })).sorted()
    }

    var totalGamesPlayed: Int {
        sessions.count
    }

    var totalScore: Int {
        sessions.reduce(0) { $0 + $1.score }
    }

    var recentSessions: [GameSession] {
        Array(sessions.prefix(10))
    }

    func bestScore(for game: String) -> Int {
        sessions.filter { $0.gameName == game }.map { $0.score }.max() ?? 0
    }

    func averageScore(for game: String) -> Double {
        let scores = sessions.filter { $0.gameName == game }.map { $0.score }
        guard !scores.isEmpty else { return 0 }
        return Double(scores.reduce(0, +)) / Double(scores.count)
    }
}
