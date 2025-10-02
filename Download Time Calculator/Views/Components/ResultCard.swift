//
//  ResultCard.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import SwiftUI

struct ResultCard: View {
    let hms: String
    let long: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Estimated Time", systemImage: "clock.fill")
                .font(.headline)

            HStack(alignment: .firstTextBaseline) {
                Text(hms)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Spacer()
            }

            Text(long)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.tertiarySystemBackground).opacity(0.7))
        )
    }
}
