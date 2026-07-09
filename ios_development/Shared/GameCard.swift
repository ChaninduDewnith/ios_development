//
//  GameCard.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
struct GameCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(color)
                    .frame(width: 52, height: 52)

                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.5))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
    }
}
