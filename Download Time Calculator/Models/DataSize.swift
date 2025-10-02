//
//  DataSize.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

struct DataSize {
    let value: Double
    let unit: DataSizeUnit
    let system: SizeSystem

    var bytes: Double {
        value * unit.bytesMultiplier(system: system)
    }
}
