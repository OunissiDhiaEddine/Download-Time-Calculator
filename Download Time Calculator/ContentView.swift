import SwiftUI

struct ContentView: View {
    @State private var downloadSize = ""
    @State private var downloadSpeed = ""
    @State private var result = ""
    @State private var isSizeInGB = false
    
    var body: some View {
        VStack {
            Text("Download Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            HStack {
                Text("Size:")
                    .font(.headline)
                    .padding()
                
                TextField("Enter size", text: $downloadSize)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.trailing)
                
                Toggle("GB", isOn: $isSizeInGB)
                    .labelsHidden()
                    .padding()
                
                Text("Unit: \(isSizeInGB ? "GB" : "MB")")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.leading)
            }
            
            HStack {
                Text("Speed:")
                    .font(.headline)
                    .padding()
                
                TextField("Enter speed in Mbps", text: $downloadSpeed)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
            }
            
            Button("Calculate") {
                calculateDownloadTime()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
            .padding()
        
            Text(result)
                .font(.body)
                .padding()
        }
        .padding()
        .background(
            Image("Background")
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    private func calculateDownloadTime() {
        guard let size = Double(downloadSize),
              let speed = Double(downloadSpeed) else {
            result = "Invalid input"
            return
        }

        let sizeInMegabytes = isSizeInGB ? size * 1024 : size
        let timeInSeconds = sizeInMegabytes / speed * 8
        let timeInMinutes = timeInSeconds / 60

        result = String(format: "Download Time: %.2f minutes", timeInMinutes)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
