//
//  DataRate.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

struct DataRate: Sendable {
    let value: Double
    let unit: DataRateUnit

    var bitsPerSecond: Double {
        value * unit.bitsPerSecondMultiplier
    }
}
