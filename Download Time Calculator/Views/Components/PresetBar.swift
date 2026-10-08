import SwiftUI

/// A horizontal row of one-tap example values.
struct PresetBar<Item: Identifiable>: View {
    let items: [Item]
    let title: KeyPath<Item, String>
    let action: (Item) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(items) { item in
                    Button(item[keyPath: title]) { action(item) }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.small)
                }
            }
        }
    }
}
