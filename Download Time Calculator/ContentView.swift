import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DownloadViewModel()
    @FocusState private var focusedField: Field?

    enum Field {
        case size, speed
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(.systemIndigo),
                    Color(.systemPurple),
                    Color(.systemPink)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    header

                    card
                }
                .padding()
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }

    private var header: some View {
        VStack(spacing: 6) {
            Label("Download Time", systemImage: "arrow.down.circle.fill")
                .font(.largeTitle.bold())
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.white)
            Text("Estimate how long a download will take based on file size and your network speed.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 8)
        .accessibilityElement(children: .combine)
    }

    private var card: some View {
        VStack(spacing: 16) {
            // Unit base toggle (1000 vs 1024)
            HStack {
                Label("Unit base", systemImage: "scalemass")
                    .font(.headline)
                Spacer()
                Picker("Unit Base", selection: $viewModel.useBinary) {
                    Text("1000 (MB/GB)").tag(false)
                    Text("1024 (MiB/GiB)").tag(true)
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 280)
            }

            // Size input
            InputRow(
                title: "Size",
                systemImage: "doc.fill",
                placeholder: "Enter file size",
                text: $viewModel.sizeText
            ) {
                SizeUnitPicker(selection: $viewModel.sizeUnit)
            }
            .focused($focusedField, equals: .size)
            .keyboardType(.decimalPad)

            // Speed input
            InputRow(
                title: "Speed",
                systemImage: "bolt.fill",
                placeholder: "Enter speed",
                text: $viewModel.speedText
            ) {
                RateUnitPicker(selection: $viewModel.rateUnit)
            }
            .focused($focusedField, equals: .speed)
            .keyboardType(.decimalPad)

            if let error = viewModel.errorMessage {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                    Text(error)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel("Error: \(error)")
            }

            Button(action: {
                viewModel.calculate()
                focusedField = nil
            }) {
                Label("Calculate", systemImage: "equal.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(viewModel.isCalculateEnabled ? Color.orange : Color.gray.opacity(0.5))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .disabled(!viewModel.isCalculateEnabled)
            .buttonStyle(.plain)
            .padding(.top, 4)

            ResultCard(
                hms: viewModel.resultHMS,
                long: viewModel.resultLong
            )
            .opacity(viewModel.hasResult ? 1 : 0.3)
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(Color.white.opacity(0.15), lineWidth: 1)
        )
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
    }
}

#Preview {
    ContentView()
}
