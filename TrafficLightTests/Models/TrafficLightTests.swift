import XCTest
@testable import TrafficLight

class TrafficLightTests: XCTestCase {
    var trafficLight: TrafficLight!

    override func setUp() {
        super.setUp()

        trafficLight = TrafficLight()
    }

    override func tearDown() {
        super.tearDown()

        trafficLight = nil
    }

    func testLightsValues() {
        XCTAssertEqual(3, TrafficLight.lights.count)
        XCTAssertEqual(TrafficLight.Light.red(4.0, .red), TrafficLight.lights[0])
        XCTAssertEqual(TrafficLight.Light.orange(1.0, .orange), TrafficLight.lights[1])
        XCTAssertEqual(TrafficLight.Light.green(4.0, .green), TrafficLight.lights[2])
    }

    func testInitialLightToBeRed() {
        XCTAssertEqual(TrafficLight.Light.red(4.0, .red), trafficLight.current.value)
        XCTAssertNotNil(TrafficLight.lights.firstIndex(of: trafficLight.current.value))
    }

    func testIfTrafficLightStopsWhenStopIsCalled() {
        let expectation = XCTestExpectation(description: "Should turn orange after red")
        let duration = trafficLight.current.value.duration
        trafficLight.start()
        trafficLight.stop()

        Timer.scheduledTimer(
            withTimeInterval: duration + 0.1,
            repeats: false) { [weak self] timer in

            if self?.trafficLight!.current.value == TrafficLight.lights[0] {
                // Current light is still red
                expectation.fulfill()
            }

        }

        wait(for: [expectation], timeout: duration + 0.2)
    }

    func testTrafficLightStartWithRedAndGoToOrange() {
        let expectation = XCTestExpectation(description: "Should turn orange after red")
        let duration = trafficLight.current.value.duration
        trafficLight.start()

        Timer.scheduledTimer(
            withTimeInterval: duration + 0.1,
            repeats: false) { [weak self] timer in


            if self?.trafficLight!.current.value == TrafficLight.lights[1] {
                // Current light is orange
                expectation.fulfill()
            }
                
            self?.trafficLight.stop()
        }

        wait(for: [expectation], timeout: duration + 0.2)
    }

    func testTrafficLightStartAndGoToGreen() {
        let expectation = XCTestExpectation(description: "Should turn orange and green after red")
        let duration = TrafficLight.lights[0].duration + TrafficLight.lights[1].duration
        trafficLight.start()

        Timer.scheduledTimer(
            withTimeInterval: duration + 0.1,
            repeats: false) { [weak self] timer in


            if self?.trafficLight!.current.value == TrafficLight.lights[2] {
                // Current light is green
                expectation.fulfill()
            }

            self?.trafficLight.stop()
        }

        wait(for: [expectation], timeout: duration + 0.2)
    }

    // Running the traffic light for 30 seconds and making sure it loops through the correct states
    func testTrafficLightsCycle() {
        let lightsCycleExpectation = XCTestExpectation(description: "Should cycle through correct colors")
        lightsCycleExpectation.isInverted = true

        var currentLight = trafficLight.current.value
        var currentIndex: Int! = TrafficLight.lights.firstIndex(of: currentLight)
        XCTAssertNotNil(currentIndex)
        
        trafficLight.start()

        Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in

            if self?.trafficLight?.current.value != currentLight {
                let nextIndex = (currentIndex + 1) % TrafficLight.lights.count
                if self?.trafficLight?.current.value != TrafficLight.lights[nextIndex] {
                    lightsCycleExpectation.fulfill()
                    timer.invalidate()
                    return
                }
                currentLight = (self?.trafficLight.current.value)!
                currentIndex = TrafficLight.lights.firstIndex(of: currentLight)
                XCTAssertNotNil(currentLight)
                XCTAssertNotNil(currentIndex)

            }
        }

        wait(for: [lightsCycleExpectation], timeout: 30.0)
    }

}
