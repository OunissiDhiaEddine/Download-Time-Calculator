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
    let finishDate: Date?
    let isActive: Bool
    let shareText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Estimated time", systemImage: "clock.fill")
                .font(.headline)

            Text(hms)
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .contentTransition(.numericText())

            Text(long)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let finishDate {
                Text("Done around \(finishDate.formatted(finishStyle(for: finishDate)))")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            if isActive {
                ShareLink(item: shareText) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.footnote)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .opacity(isActive ? 1 : 0.5)
        .animation(.default, value: hms)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(isActive ? "Estimated time \(long)" : "Enter a size and speed to see the estimated time")
    }

    private func finishStyle(for date: Date) -> Date.FormatStyle {
        Calendar.current.isDateInToday(date)
            ? .dateTime.hour().minute()
            : .dateTime.weekday(.abbreviated).hour().minute()
    }
}
