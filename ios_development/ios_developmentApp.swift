//
//  ios_developmentApp.swift
//  ios_development
//
//  Created by student2 on 2026-06-11.
//

import SwiftUI
import SwiftData

@main
struct ios_developmentApp: App {
    @State private var locationService = LocationService()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(locationService)
                .onAppear {
                    locationService.requestPermissionOnLaunch()
                }
        }
        .modelContainer(for: GameSession.self)
    }
}
