import XCTest
@testable import TrafficLight

class TrafficLightScreenViewModelTests: XCTestCase {
    var mock = TrafficLightMock()
    var viewModel: TrafficLightScreenViewModel!

    override func setUp() {
        viewModel = TrafficLightScreenViewModel(model: mock)
    }

    override func tearDown() {
        viewModel = nil
        XCTAssertTrue(mock.stopCalled)
    }

    func testLightsInitializer() {
        XCTAssertEqual(TrafficLight.lights.count, viewModel.lights.count)
        TrafficLight.lights.enumerated().forEach { index, item in
            XCTAssertEqual(item, viewModel.lights[index].light)
        }
        XCTAssertTrue(mock.startCalled)
    }

    func testChangingCurrentLightToRed() {
        mock.setLight(light: TrafficLight.lights[0])
        XCTAssertEqual(viewModel.lights.count, 3)
        TrafficLight.lights.enumerated().forEach { index, item in
            XCTAssertEqual(item, viewModel.lights[index].light)
        }

        // Assert Red is Active
        XCTAssertEqual(viewModel.lights[0].opacity, ActiveLightOpacity)

        // Assert Orange is Inactive
        XCTAssertEqual(viewModel.lights[1].opacity, InactiveLightOpacity)

        // Assert Green is Inactive
        XCTAssertEqual(viewModel.lights[2].opacity, InactiveLightOpacity)
    }

    func testChangingCurrentLightToOrange() {
        mock.setLight(light: TrafficLight.lights[1])
        XCTAssertEqual(viewModel.lights.count, 3)
        TrafficLight.lights.enumerated().forEach { index, item in
            XCTAssertEqual(item, viewModel.lights[index].light)
        }

        // Assert Red is Inactive
        XCTAssertEqual(viewModel.lights[0].opacity, InactiveLightOpacity)

        // Assert Orange is Active
        XCTAssertEqual(viewModel.lights[1].opacity, ActiveLightOpacity)

        // Assert Green is Inactive
        XCTAssertEqual(viewModel.lights[2].opacity, InactiveLightOpacity)
    }

    func testChangingCurrentLightToGreen() {
        mock.setLight(light: TrafficLight.lights[2])
        XCTAssertEqual(viewModel.lights.count, 3)
        TrafficLight.lights.enumerated().forEach { index, item in
            XCTAssertEqual(item, viewModel.lights[index].light)
        }

        // Assert Red is Inactive
        XCTAssertEqual(viewModel.lights[0].opacity, InactiveLightOpacity)

        // Assert Orange is Inactive
        XCTAssertEqual(viewModel.lights[1].opacity, InactiveLightOpacity)

        // Assert Green is Active
        XCTAssertEqual(viewModel.lights[2].opacity, ActiveLightOpacity)
    }

    func testChangingCurrentLightMultipleTimes() {
        for i in 1..<30 {
            let current = i % TrafficLight.lights.count
            let previous = (i - 1) % TrafficLight.lights.count
            let next = (i + 1) % TrafficLight.lights.count

            mock.setLight(light: TrafficLight.lights[current])
            XCTAssertEqual(viewModel.lights.count, 3)

            // Assert current is Active
            XCTAssertEqual(viewModel.lights[current].opacity, ActiveLightOpacity)

            // Assert previous index is Inactive
            XCTAssertEqual(viewModel.lights[previous].opacity, InactiveLightOpacity)

            // Assert next index is Inactive
            XCTAssertEqual(viewModel.lights[next].opacity, InactiveLightOpacity)
        }
    }
}
