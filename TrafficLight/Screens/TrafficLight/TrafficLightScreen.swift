//
//  TrafficLightView.swift
//  TrafficLight
//
//  Created by Stanislav Vlaev on 30.04.24.
//

import SwiftUI

struct TrafficLightScreen: View {
    @ObservedObject var viewModel = TrafficLightScreenViewModel()
    var carModel: String

    var body: some View {
        VStack {
            Spacer()
        }
        .navigationTitle("Driving \(carModel)")
    }
}

#Preview {
    TrafficLightScreen(carModel: "Some Car Name")
}
