import Foundation
@testable import TrafficLight

class TrafficLightMock: TrafficLight {
    var startCalled = false
    var stopCalled = false

    override func start() {
        super.start()
        startCalled = true
    }

    override func stop() {
        super.stop()
        stopCalled = true
    }
}

extension TrafficLight {
    func setLight(light: TrafficLight.Light) {
        current.send(light)
    }
}
