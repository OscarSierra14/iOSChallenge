//
//  InitialModulePresenterTest.swift
//  ChallengeiOSTests
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import XCTest
@testable import ChallengeiOS

class WeatherPresenterTest: XCTestCase {
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    var sut: WeatherPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = WeatherPresenter()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }

    func test_fetchWeatherRequest() {
        sut.fetchWeatherSuccessResponse(data: [WheatherDataTableView(week: "", icon: "", description: "")])
        
        XCTAssertTrue(mockView.displayWetherInformationCalled)
    }

    func test_fetchWeatherFailure() {
        sut.fetchWeatherFailureResponse()
    }
    
    //MARK: Interactor
    class MockInteractor: WeatherInteractorProtocol {
        var requestWeatherCalled = false

        func requestWeather() {
            requestWeatherCalled = true
        }
        
        var networkManager: NetworkingSiteAdapterProtocol?
        var fetchAcromineCalled = false
        
        func fetchAcromine(with inputText: String) {
            fetchAcromineCalled = true
        }
        
        var presenter: WeatherInteractorOutputProtocol?
    }
    
    //MARK: Router
    class MockRouter: WeatherRouterProtocol {
        var viewController: UIViewController?
        var showAlertCalled = false
        static func createWeatherModule() -> WeatherViewController {
            return WeatherViewController()
        }
        
        func showAlert(with error: String) {
            showAlertCalled = true
        }
    }
    
    //MARK: View
    class MockView: WeatherViewProtocol {
        var presenter: WeatherPresenterProtocol?
        var displayWetherInformationCalled = false

        func displayWetherInformation(data: [WheatherDataTableView]) {
            displayWetherInformationCalled = true
        }
        
    }
}
