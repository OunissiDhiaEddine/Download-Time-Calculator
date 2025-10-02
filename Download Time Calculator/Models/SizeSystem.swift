//
//  SizeSystem.swift
//  Download Time Calculator
//
//  Created by Dhia Eddine Ounissi on 2025-10-02.
//


import Foundation

enum SizeSystem: String, CaseIterable, Identifiable {
    case decimal // 1000-based (MB, GB, TB)
    case binary  // 1024-based (MiB, GiB, TiB)

    var id: Self { self }

    var base: Double {
        switch self {
        case .decimal: return 1000
        case .binary:  return 1024
        }
    }

    var label: String {
        switch self {
        case .decimal: return "1000 (MB/GB)"
        case .binary:  return "1024 (MiB/GiB)"
        }
    }
}
