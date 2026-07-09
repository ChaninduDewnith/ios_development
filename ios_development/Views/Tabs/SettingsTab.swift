//
//  SettingsTab.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("dailyChallengeEnabled") private var isEnabled = false
    @AppStorage("dailyChallengeTimeInterval") private var timeInterval: Double = Date().timeIntervalSince1970

    @Environment(\.modelContext) private var modelContext
    @State private var showResetConfirmation = false
    @State private var didReset = false

    private var selectedTime: Binding<Date> {
        Binding(
            get: { Date(timeIntervalSince1970: timeInterval) },
            set: { timeInterval = $0.timeIntervalSince1970 }
        )
    }

    var body: some View {
        Form {
            Section {
                Toggle("Remind me every day", isOn: $isEnabled)
                    .onChange(of: isEnabled) { _, newValue in
                        if newValue {
                            NotificationService.shared.requestPermission()
                            NotificationService.shared.scheduleDailyChallenge(at: selectedTime.wrappedValue)
                        } else {
                            NotificationService.shared.cancelDailyChallenge()
                        }
                    }

                if isEnabled {
                    DatePicker("Reminder time", selection: selectedTime, displayedComponents: .hourAndMinute)
                        .onChange(of: timeInterval) { _, _ in
                            NotificationService.shared.scheduleDailyChallenge(at: selectedTime.wrappedValue)
                        }
                }
            } header: {
                Text("Daily challenge")
            } footer: {
                Text("You'll get a reminder to come back and play at the time you choose.")
            }

            Section {
                Button("Reset all stats", role: .destructive) {
                    showResetConfirmation = true
                }
            } footer: {
                Text("This permanently deletes every recorded game session, including scores and map pins. This can't be undone.")
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog(
            "Reset all stats?",
            isPresented: $showResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete everything", role: .destructive) {
                resetAllStats()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently delete all game sessions. This can't be undone.")
        }
        .alert("Stats reset", isPresented: $didReset) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("All game sessions have been deleted.")
        }
    }

    private func resetAllStats() {
        do {
            try modelContext.delete(model: GameSession.self)
            didReset = true
        } catch {
            print("Failed to reset stats: \(error.localizedDescription)")
        }
    }
}


