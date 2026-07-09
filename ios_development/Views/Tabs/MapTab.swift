//
//  MapTab.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    @Query(sort: \GameSession.date, order: .reverse) private var sessions: [GameSession]
    @State private var selectedSession: GameSession?
    @State private var cameraPosition: MapCameraPosition = .automatic

    private var sessionsWithLocation: [GameSession] {
        sessions.filter { $0.hasLocation }
    }

    var body: some View {
        Group {
            if sessionsWithLocation.isEmpty {
                ContentUnavailableView(
                    "No locations yet",
                    systemImage: "map",
                    description: Text("Play a game with location access enabled to see it show up here.")
                )
            } else {
                Map(position: $cameraPosition, selection: $selectedSession) {
                    ForEach(sessionsWithLocation) { session in
                        Marker(session.gameName, systemImage: "star.fill", coordinate: session.coordinate)
                            .tint(.purple)
                            .tag(session)
                    }
                }
                .sheet(item: $selectedSession) { session in
                    SessionDetailSheet(session: session)
                        .presentationDetents([.height(180)])
                }
            }
        }
        .navigationTitle("Game map")
    }
}

private struct SessionDetailSheet: View {
    let session: GameSession

    var body: some View {
        VStack(spacing: 10) {
            Text(session.gameName)
                .font(.title2.bold())
            Text("Score: \(session.score)")
                .font(.title3)
            Text(session.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

