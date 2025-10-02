//
//  DataSizeUnit.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum DataSizeUnit: String, CaseIterable, Identifiable {
    case MB, GB, TB

    var id: Self { self }

    func bytesMultiplier(system: SizeSystem) -> Double {
        let b = system.base
        switch self {
        case .MB: return pow(b, 2) // MB or MiB
        case .GB: return pow(b, 3) // GB or GiB
        case .TB: return pow(b, 4) // TB or TiB
        }
    }

    var displayName: String {
        rawValue
    }
}
