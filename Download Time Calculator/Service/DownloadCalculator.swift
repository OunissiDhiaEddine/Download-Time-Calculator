//
//  DownloadCalculator.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum DownloadCalculator {
    /// Returns time in seconds to download a given size at a given rate.
    /// `efficiency` (0...1] is the share of the nominal speed actually achieved
    /// after protocol overhead and congestion; 1 means the full advertised speed.
    static func timeToDownload(size: DataSize, at rate: DataRate, efficiency: Double = 1) -> TimeInterval? {
        guard efficiency > 0, efficiency <= 1 else { return nil }
        let bps = rate.bitsPerSecond * efficiency
        guard bps > 0 else { return nil }
        let totalBits = size.bytes * 8.0
        return totalBits / bps
    }
}
