//
//  InputRow.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import SwiftUI

struct InputRow<Trailing: View>: View {
    let title: String
    let systemImage: String
    let placeholder: String
    @Binding var text: String
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(.tint)
                .font(.title3)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)

                HStack {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel(title)

                    trailing()
                }
            }
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
