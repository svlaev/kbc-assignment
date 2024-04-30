import Foundation
import Combine

let ActiveLightOpacity: Double = 1.0
let InactiveLightOpacity: Double = 0.1

class TrafficLightScreenViewModel: ObservableObject {
    struct Item: Identifiable {
        var id: UUID
        var light: TrafficLight.Light
        var opacity: Double

        init(light: TrafficLight.Light, opacity: Double) {
            self.id = UUID()
            self.light = light
            self.opacity = opacity
        }
    }

    @Published private(set) var lights: [Item] = []

    private var model: TrafficLight
    private var cancellables = Set<AnyCancellable>()

    init(model: TrafficLight = TrafficLight()) {
        self.model = model

        TrafficLight.lights.forEach { [weak self] in
            self?.lights.append(Item(light: $0, opacity: InactiveLightOpacity))
        }

        model.current
            .sink { [weak self] newValue in
                self?.render()
            }
            .store(in: &cancellables)

        model.start()
    }

    func viewDisappear() {
        model.stop()
    }

    deinit {
        model.stop()
    }

    private func render() {
        for i in lights.indices {
            lights[i].opacity =
                model.current.value == lights[i].light ? ActiveLightOpacity : InactiveLightOpacity
        }
    }
}
