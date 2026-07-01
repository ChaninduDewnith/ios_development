//
//  GameItem.swift
//  ios_development
//
//  Created by student2 on 2026-07-01.
//

import SwiftUI

struct GameItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let tint: Color
    let bgTint: Color
    let cardTint: Color
    let destination: AnyView
}
