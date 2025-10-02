import SwiftUI

struct SizeUnitPicker: View {
    @Binding var selection: DataSizeUnit

    var body: some View {
        Picker("Size Unit", selection: $selection) {
            ForEach(DataSizeUnit.allCases) { unit in
                Text(unit.displayName).tag(unit)
            }
        }
        .pickerStyle(.menu)
        .tint(.primary)
        .frame(minWidth: 90)
    }
}

struct RateUnitPicker: View {
    @Binding var selection: DataRateUnit

    var body: some View {
        Picker("Speed Unit", selection: $selection) {
            ForEach(DataRateUnit.allCases) { unit in
                Text(unit.displayName).tag(unit)
            }
        }
        .pickerStyle(.menu)
        .tint(.primary)
        .frame(minWidth: 90)
    }
}
