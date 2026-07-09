//
//  GameSession.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class GameSession {
    var id: UUID
    var gameName: String
    var score: Int
    var date: Date
    var latitude: Double?
    var longitude: Double?

    init(gameName: String, score: Int, date: Date = .now, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = UUID()
        self.gameName = gameName
        self.score = score
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }


    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }

    var hasLocation: Bool {
        latitude != nil && longitude != nil
    }
}
