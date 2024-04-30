//
//  MainViewModel.swift
//  TrafficLight
//
//  Created by Stanislav Vlaev on 30.04.24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var carModel = ""
    @Published var validationError = ""
    @Published var shouldStartDriving = false

    func onViewAppear() {
        shouldStartDriving = false
        validationError = ""
        carModel = ""
    }

    func startDriving() {
        if validateInput() {
            shouldStartDriving = true
        }
    }

    private func validateInput() -> Bool {
        let validInput = carModel.count > 3
        validationError = validInput ? "" : "Car model should be longer than 3 symbols"

        return validInput
    }
}
