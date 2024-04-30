import SwiftUI

struct TrafficLightScreen: View {
    @ObservedObject var viewModel = TrafficLightScreenViewModel()
    var carModel = ""

    var body: some View {
        VStack {
            Text("Driving \(carModel)")
            Spacer()
            ForEach(viewModel.lights) { item in
                Circle()
                    .fill(item.light.color.opacity(item.opacity))
                    .frame(maxWidth: 100)
            }
            Spacer()
        }
        .padding()
        .onDisappear {
            viewModel.viewDisappear()
        }
    }
}

#Preview {
    TrafficLightScreen(carModel: "Some Car Name")
}
