import Foundation

/// A one-tap example value for the size or speed field.
struct SizePreset: Identifiable, Sendable {
    let name: String
    let value: Double
    let unit: DataSizeUnit
    var id: String { name }

    static let all: [SizePreset] = [
        SizePreset(name: "Song", value: 10, unit: .MB),
        SizePreset(name: "Movie (HD)", value: 4, unit: .GB),
        SizePreset(name: "iOS update", value: 6, unit: .GB),
        SizePreset(name: "Big game", value: 100, unit: .GB),
    ]
}

struct SpeedPreset: Identifiable, Sendable {
    let name: String
    let value: Double
    let unit: DataRateUnit
    var id: String { name }

    static let all: [SpeedPreset] = [
        SpeedPreset(name: "4G", value: 30, unit: .Mbps),
        SpeedPreset(name: "Wi-Fi", value: 100, unit: .Mbps),
        SpeedPreset(name: "Fibre", value: 500, unit: .Mbps),
        SpeedPreset(name: "Gigabit", value: 1, unit: .Gbps),
    ]
}
