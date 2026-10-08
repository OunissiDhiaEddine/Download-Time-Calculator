import SwiftUI

/// The same download at a range of common connection speeds.
struct ComparisonList: View {
    let rows: [(name: String, seconds: TimeInterval)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("At other speeds")
                .font(.headline)

            ForEach(rows, id: \.name) { row in
                HStack {
                    Text(row.name)
                    Spacer()
                    Text(DurationFormatter.longString(seconds: row.seconds))
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                }
                .font(.subheadline)
                .accessibilityElement(children: .combine)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
