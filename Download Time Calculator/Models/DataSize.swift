import Foundation

struct DataSize {
    let value: Double
    let unit: DataSizeUnit
    let system: SizeSystem

    var bytes: Double {
        value * unit.bytesMultiplier(system: system)
    }
}
