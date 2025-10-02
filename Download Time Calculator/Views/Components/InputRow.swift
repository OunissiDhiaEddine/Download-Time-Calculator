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
                .foregroundStyle(.blue)
                .font(.title3)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)

                HStack {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                    trailing()
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.secondarySystemBackground).opacity(0.6))
        )
    }
}
