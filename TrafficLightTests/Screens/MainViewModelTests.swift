//
//  MainViewModelTests.swift
//  TrafficLightTests
//
//  Created by Stanislav Vlaev on 30.04.24.
//

import XCTest
@testable import TrafficLight

class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!

    override func setUp() {
        super.setUp()

        viewModel = MainViewModel()
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
    }

    func testInitialStateOfViewModel() {
        XCTAssertEqual("", viewModel.carModel)
        XCTAssertEqual("", viewModel.validationError)
        XCTAssertFalse(viewModel.shouldStartDriving)
    }

    func testIfOnViewAppearClearsState() {
        viewModel.carModel = "Some car model"
        viewModel.validationError = "Validation error"
        viewModel.shouldStartDriving = true

        viewModel.onViewAppear()

        XCTAssertEqual("", viewModel.carModel)
        XCTAssertEqual("", viewModel.validationError)
        XCTAssertFalse(viewModel.shouldStartDriving)
    }

    func testStartDrivingWithInvalidInput() {
        assertInvalidInput(input: "")
        assertInvalidInput(input: "a")
        assertInvalidInput(input: "ab")
        assertInvalidInput(input: "abc")
    }

    func testStartDrivingWithValidInput() {
        assertValidInput(input: "abcd")
        assertValidInput(input: "Abcd")
        assertValidInput(input: "Some longer text")
    }

    private func assertValidInput(input: String) {
        viewModel.carModel = input
        viewModel.validationError = ""
        viewModel.shouldStartDriving = false

        viewModel.startDriving()

        XCTAssertEqual(input, viewModel.carModel)
        XCTAssertEqual("", viewModel.validationError)
        XCTAssertTrue(viewModel.shouldStartDriving)
    }

    private func assertInvalidInput(input: String) {
        viewModel.carModel = input
        viewModel.validationError = ""
        viewModel.shouldStartDriving = false

        viewModel.startDriving()

        XCTAssertEqual(input, viewModel.carModel)
        XCTAssertEqual("Car model should be longer than 3 symbols", viewModel.validationError)
        XCTAssertFalse(viewModel.shouldStartDriving)
    }
}
