//
//  DataRateUnit.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum DataRateUnit: String, CaseIterable, Identifiable {
    // Networking speeds are commonly decimal-based (K/M/G bits per second)
    case Kbps, Mbps, Gbps

    var id: Self { self }

    var bitsPerSecondMultiplier: Double {
        switch self {
        case .Kbps: return 1_000
        case .Mbps: return 1_000_000
        case .Gbps: return 1_000_000_000
        }
    }

    var displayName: String {
        rawValue
    }
}
