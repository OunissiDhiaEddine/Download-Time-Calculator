//
//  DownloadViewModel.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation
import Combine

final class DownloadViewModel: ObservableObject {
    // Inputs
    @Published var sizeText: String = ""
    @Published var speedText: String = ""
    @Published var sizeUnit: DataSizeUnit = .GB
    @Published var rateUnit: DataRateUnit = .Mbps
    @Published var useBinary: Bool = true

    // Outputs
    @Published private(set) var resultHMS: String = "—"
    @Published private(set) var resultLong: String = "—"
    @Published private(set) var errorMessage: String?
    @Published private(set) var hasResult: Bool = false

    var isCalculateEnabled: Bool {
        parsedSize != nil && parsedSpeed != nil && (parsedSpeed ?? 0) > 0
    }

    private var parsedSize: Double? {
        parseNumber(sizeText)
    }

    private var parsedSpeed: Double? {
        parseNumber(speedText)
    }

    func calculate() {
        errorMessage = nil
        hasResult = false
        resultHMS = "—"
        resultLong = "—"

        guard let sizeValue = parsedSize, sizeValue >= 0 else {
            errorMessage = "Please enter a valid size."
            return
        }
        guard let speedValue = parsedSpeed, speedValue > 0 else {
            errorMessage = "Please enter a valid speed greater than zero."
            return
        }

        let system: SizeSystem = useBinary ? .binary : .decimal
        let size = DataSize(value: sizeValue, unit: sizeUnit, system: system)
        let rate = DataRate(value: speedValue, unit: rateUnit)

        guard let seconds = DownloadCalculator.timeToDownload(size: size, at: rate) else {
            errorMessage = "Unable to compute with the provided values."
            return
        }

        resultHMS = DurationFormatter.hmsString(seconds: seconds)
        resultLong = DurationFormatter.longString(seconds: seconds)
        hasResult = true
    }

    // MARK: - Parsing

    private lazy var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = .current
        nf.numberStyle = .decimal
        nf.isLenient = true
        return nf
    }()

    private func parseNumber(_ text: String) -> Double? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        if let n = numberFormatter.number(from: trimmed) {
            return n.doubleValue
        }
        // Fallback: swap comma and dot if needed
        if trimmed.contains(",") {
            let replaced = trimmed.replacingOccurrences(of: ",", with: ".")
            return Double(replaced)
        } else if trimmed.contains(".") {
            let replaced = trimmed.replacingOccurrences(of: ".", with: ",")
            return numberFormatter.number(from: replaced)?.doubleValue
        }
        return Double(trimmed)
    }
}
