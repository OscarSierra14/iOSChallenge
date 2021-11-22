//
//  InitialModuleInteractorTest.swift
//  ChallengeiOSTests
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import XCTest
@testable import ChallengeiOS

class WeatherInteractorTest: XCTestCase {
    private let jsonRequest = "requestWithHTTP"
    var mockPresenter: MockPresenter!
    var sut: WeatherInteractor!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        sut = WeatherInteractor()
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        sut = nil
    }
    
    func test_fetchWeatherSuccess() {
        setupNetworkingSiteAdapter(file: jsonRequest, code: 200, error: nil)
        
        sut.requestWeather()
        
        XCTAssertTrue(mockPresenter.fetchWeatherSuccessResponseCalled)
    }
    
    func test_fetchWeatherFailure() {
        setupNetworkingSiteAdapter(file: jsonRequest, code: 400, error: nil)
        
        sut.requestWeather()
        
        XCTAssertTrue(mockPresenter.fetchWeatherFailureResponseCalled)
    }

    class MockPresenter: WeatherInteractorOutputProtocol {
        var fetchWeatherSuccessResponseCalled = false
        var fetchWeatherFailureResponseCalled = false

        func fetchWeatherSuccessResponse(data: [WheatherDataTableView]) {
            fetchWeatherSuccessResponseCalled = true
        }
        
        func fetchWeatherFailureResponse() {
            fetchWeatherFailureResponseCalled = true
        }
    }
    
    
    private func setupNetworkingSiteAdapter(file: String = String(), code: Int, error: Error? = nil) {
        let router = MockRouter.shared.createMockSession(fromJsonFile: file, andStatusCode: code, andError: error, as: NetworkingSiteAPI.self)
        let service = NetworkingSiteRouter(router)
        sut.networkManager = NetworkingSiteAdapter(service)
    }
}
