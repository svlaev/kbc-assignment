import Foundation
import Combine
import SwiftUI

class TrafficLight {
    enum Light: Equatable {
        case red(Double, Color)
        case orange(Double, Color)
        case green(Double, Color)

        var duration: Double {
            switch self {
            case .red(let duration, _), .orange(let duration, _), .green(let duration, _):
                return duration
            }
        }

        var color: Color {
            switch self {
            case .red(_, let color), .orange(_, let color), .green(_, let color):
                return color
            }
        }
    }

    static let lights: [Light] = [
        .red(4.0, .red),
        .orange(1.0, .orange),
        .green(4.0, .green)
    ]

    private(set) var current = CurrentValueSubject<TrafficLight.Light, Never>(TrafficLight.lights[0])

    private var cancelled = false

    func start() {
        cancelled = false

        countDownToNextLight()
    }

    func stop() {
        cancelled = true
    }

    private func countDownToNextLight() {
        Timer.scheduledTimer(
            withTimeInterval: current.value.duration,
            repeats: false) { [weak self] timer in
            
            self?.advanceToNextLight()
        }
    }

    private func advanceToNextLight() {
        guard !cancelled else {
            return
        }

        guard let currentIndex = TrafficLight.lights.firstIndex(of: self.current.value) else {
            stop()
            return
        }

        let nextIndex = (currentIndex + 1) % TrafficLight.lights.count
        current.send(TrafficLight.lights[nextIndex])
        countDownToNextLight()
    }
}
