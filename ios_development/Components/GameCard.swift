//
//  GameCard.swift
//  ios_development
//
//  Created by student2 on 2026-07-01.
//
import SwiftUI

struct GameCard: View {
    let game: GameItem
    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(game.bgTint)
                .frame(width: 46, height: 46)
                .overlay(
                    Image(systemName: game.icon)
                        .font(.system(size: 20))
                        .foregroundColor(game.tint)
                )
            Text(game.title)
                .font(.subheadline.weight(.medium))
                .foregroundColor(game.tint)
            Spacer()
            Text("Play")
                .font(.caption.weight(.medium))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 9)
                .background(game.tint)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(14)
        .background(game.cardTint)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
