//
//  GameItem.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
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
