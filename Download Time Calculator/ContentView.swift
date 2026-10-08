import SwiftUI

struct ContentView: View {
    @State private var viewModel = DownloadViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ResultCard(
                        hms: viewModel.resultHMS,
                        long: viewModel.resultLong,
                        finishDate: viewModel.finishDate,
                        isActive: viewModel.hasResult,
                        shareText: viewModel.shareText
                    )

                    InputRow(
                        title: "File size",
                        systemImage: "doc.fill",
                        placeholder: "e.g. 4",
                        text: $viewModel.sizeText
                    ) {
                        SizeUnitPicker(selection: $viewModel.sizeUnit)
                    }
                    PresetBar(items: SizePreset.all, title: \.name) { viewModel.apply($0) }

                    InputRow(
                        title: "Download speed",
                        systemImage: "bolt.fill",
                        placeholder: "e.g. 100",
                        text: $viewModel.speedText
                    ) {
                        RateUnitPicker(selection: $viewModel.rateUnit)
                    }
                    PresetBar(items: SpeedPreset.all, title: \.name) { viewModel.apply($0) }

                    if let error = viewModel.errorMessage {
                        Label(error, systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(.orange)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityLabel("Error: \(error)")
                    }

                    optionsCard(viewModel: $viewModel)

                    if viewModel.hasResult {
                        ComparisonList(rows: viewModel.comparison)
                    }
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Download Time")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset", systemImage: "arrow.counterclockwise") {
                        viewModel.reset()
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil, from: nil, for: nil
                        )
                    }
                }
            }
        }
    }

    private func optionsCard(viewModel: Bindable<DownloadViewModel>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker("Unit base", selection: viewModel.useBinary) {
                Text("1000 (MB/GB)").tag(false)
                Text("1024 (MiB/GiB)").tag(true)
            }
            .pickerStyle(.segmented)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Real-world speed")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text(viewModel.wrappedValue.efficiency, format: .percent.precision(.fractionLength(0)))
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                Slider(value: viewModel.efficiency, in: 0.5...1, step: 0.05)
                Text("Downloads rarely hit the advertised speed. Lower this to allow for overhead and congestion.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    ContentView()
}
