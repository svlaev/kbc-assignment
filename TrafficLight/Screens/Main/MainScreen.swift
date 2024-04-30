//
//  ContentView.swift
//  TrafficLight
//
//  Created by Stanislav Vlaev on 30.04.24.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter car model", text: $viewModel.carModel)

                if !($viewModel.validationError.wrappedValue.isEmpty) {
                    Text(viewModel.validationError)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .font(.system(size: 12.0))
                }

                Button(action: {
                    viewModel.startDriving()
                }, label: {
                    Text("Start driving")
                })
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Vehicle")
            .navigationDestination(isPresented: $viewModel.shouldStartDriving, destination: {
                if viewModel.shouldStartDriving {
                    TrafficLightScreen(carModel: viewModel.carModel)
                } else {
                    EmptyView()
                }
            })
            .onAppear {
                viewModel.onViewAppear()
            }
        }
    }
}

#Preview {
    MainScreen()
}
