//
//  NotificationService.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()
    private let dailyChallengeID = "dailyChallenge"

    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    
    func scheduleDailyChallenge(at time: Date) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [dailyChallengeID])

        let content = UNMutableNotificationContent()
        content.title = "Daily challenge"
        content.body = "Your daily challenge is ready. Come beat your best score!"
        content.sound = .default

        var components = Calendar.current.dateComponents([.hour, .minute], from: time)
        components.second = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: dailyChallengeID, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }

    func cancelDailyChallenge() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dailyChallengeID])
    }
}



