//
//  WeatherProtocols.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

protocol WeatherInteractorProtocol: AnyObject {
    var presenter: WeatherInteractorOutputProtocol? { get set }
    var networkManager: NetworkingSiteAdapterProtocol? { get set }
    func requestWeather()
}

protocol WeatherPresenterProtocol: AnyObject {
    var model: String? { get set }
    var view: WeatherViewProtocol? { get set }
    var router: WeatherRouterProtocol? { get set }
    var interactor: WeatherInteractorProtocol? { get set }
    func viewDidLoad()
}

protocol WeatherInteractorOutputProtocol: AnyObject {
    func fetchWeatherSuccessResponse(data: [WheatherDataTableView])
    func fetchWeatherFailureResponse()
}

protocol WeatherRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createWeatherModule() -> WeatherViewController
    func showAlert(with error: String)
}

protocol WeatherViewProtocol: AnyObject {
    var presenter: WeatherPresenterProtocol? { get set }
    func displayWetherInformation(data: [WheatherDataTableView])
}
