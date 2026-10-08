//
//  DataRateUnit.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum DataRateUnit: String, CaseIterable, Identifiable, Sendable {
    // Networking speeds are commonly decimal-based (K/M/G bits per second).
    // MBps is megabytes per second, as shown by many download managers.
    case Kbps, Mbps, Gbps, MBps

    var id: Self { self }

    var bitsPerSecondMultiplier: Double {
        switch self {
        case .Kbps: return 1_000
        case .Mbps: return 1_000_000
        case .Gbps: return 1_000_000_000
        case .MBps: return 8_000_000
        }
    }

    var displayName: String {
        self == .MBps ? "MB/s" : rawValue
    }
}
