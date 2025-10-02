//
//  DownloadCalculator.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum DownloadCalculator {
    /// Returns time in seconds to download a given size at a given rate.
    static func timeToDownload(size: DataSize, at rate: DataRate) -> TimeInterval? {
        let bps = rate.bitsPerSecond
        guard bps > 0 else { return nil }
        let totalBits = size.bytes * 8.0
        return totalBits / bps
    }
}
