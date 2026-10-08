//
//  DownloadViewModel.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation
import Observation

@Observable
final class DownloadViewModel {
    // Inputs (the last values are remembered between launches)
    var sizeText: String { didSet { save(sizeText, for: Key.size) } }
    var speedText: String { didSet { save(speedText, for: Key.speed) } }
    var sizeUnit: DataSizeUnit { didSet { save(sizeUnit.rawValue, for: Key.sizeUnit) } }
    var rateUnit: DataRateUnit { didSet { save(rateUnit.rawValue, for: Key.rateUnit) } }
    var useBinary: Bool { didSet { save(useBinary, for: Key.binary) } }
    /// Share of the advertised speed actually achieved, 0.5...1.
    var efficiency: Double { didSet { save(efficiency, for: Key.efficiency) } }

    /// "Other speeds" shown in the comparison list.
    static let comparisonSpeeds: [SpeedPreset] = [
        SpeedPreset(name: "10 Mbps", value: 10, unit: .Mbps),
        SpeedPreset(name: "50 Mbps", value: 50, unit: .Mbps),
        SpeedPreset(name: "100 Mbps", value: 100, unit: .Mbps),
        SpeedPreset(name: "500 Mbps", value: 500, unit: .Mbps),
        SpeedPreset(name: "1 Gbps", value: 1, unit: .Gbps),
    ]

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        sizeText = defaults.string(forKey: Key.size) ?? ""
        speedText = defaults.string(forKey: Key.speed) ?? ""
        sizeUnit = defaults.string(forKey: Key.sizeUnit).flatMap(DataSizeUnit.init) ?? .GB
        rateUnit = defaults.string(forKey: Key.rateUnit).flatMap(DataRateUnit.init) ?? .Mbps
        useBinary = defaults.object(forKey: Key.binary) as? Bool ?? true
        let savedEfficiency = defaults.object(forKey: Key.efficiency) as? Double ?? 1
        efficiency = min(max(savedEfficiency, 0.5), 1)
    }

    // MARK: - Outputs (computed live from the inputs)

    private var size: DataSize? {
        guard let value = NumberParser.parse(sizeText), value >= 0 else { return nil }
        return DataSize(value: value, unit: sizeUnit, system: useBinary ? .binary : .decimal)
    }

    private var rate: DataRate? {
        guard let value = NumberParser.parse(speedText), value > 0 else { return nil }
        return DataRate(value: value, unit: rateUnit)
    }

    /// Seconds for the current inputs, or nil until both fields are valid.
    var seconds: TimeInterval? {
        guard let size, let rate else { return nil }
        return DownloadCalculator.timeToDownload(size: size, at: rate, efficiency: efficiency)
    }

    var hasResult: Bool { seconds != nil }

    var resultHMS: String { seconds.map(DurationFormatter.hmsString) ?? "—" }
    var resultLong: String { seconds.map(DurationFormatter.longString) ?? "—" }

    var finishDate: Date? {
        seconds.map { Date.now.addingTimeInterval($0) }
    }

    /// A message only when the user has typed something that cannot be used.
    var errorMessage: String? {
        if !sizeText.isEmpty && size == nil { return "Please enter a valid size." }
        if !speedText.isEmpty && rate == nil { return "Please enter a speed greater than zero." }
        return nil
    }

    /// Same download at a range of common speeds.
    var comparison: [(name: String, seconds: TimeInterval)] {
        guard let size else { return [] }
        return Self.comparisonSpeeds.compactMap { preset in
            let rate = DataRate(value: preset.value, unit: preset.unit)
            guard let t = DownloadCalculator.timeToDownload(size: size, at: rate, efficiency: efficiency) else { return nil }
            return (preset.name, t)
        }
    }

    var shareText: String {
        guard hasResult else { return "" }
        return "\(sizeText) \(sizeUnit.displayName) at \(speedText) \(rateUnit.displayName) takes about \(resultLong)."
    }

    // MARK: - Actions

    func apply(_ preset: SizePreset) {
        sizeText = NumberParser.string(from: preset.value)
        sizeUnit = preset.unit
    }

    func apply(_ preset: SpeedPreset) {
        speedText = NumberParser.string(from: preset.value)
        rateUnit = preset.unit
    }

    func reset() {
        sizeText = ""
        speedText = ""
        efficiency = 1
    }

    // MARK: - Persistence

    private enum Key {
        static let size = "sizeText"
        static let speed = "speedText"
        static let sizeUnit = "sizeUnit"
        static let rateUnit = "rateUnit"
        static let binary = "useBinary"
        static let efficiency = "efficiency"
    }

    private func save(_ value: Any, for key: String) {
        defaults.set(value, forKey: key)
    }
}
