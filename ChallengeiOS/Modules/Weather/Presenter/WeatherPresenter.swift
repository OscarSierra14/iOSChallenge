//
//  WeatherPresenter.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WeatherPresenter: WeatherPresenterProtocol {
    var model: String?
    weak var view: WeatherViewProtocol?
    var router: WeatherRouterProtocol?
    var interactor: WeatherInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.requestWeather()
    }
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func fetchWeatherSuccessResponse(data: [WheatherDataTableView]) {
        view?.displayWetherInformation(data: data)
    }
    
    func fetchWeatherFailureResponse() {
        
    }
}
