//
//  NetworkingSiteProtocols.swift
//  ChallengeiOS
//
//  Created by Oscar Eduardo Sierra Zuniga on 21/06/20.
//  Copyright (c) 2020 Oscar Sierra Z. All rights reserved.
//

import Foundation

protocol NetworkingSiteAdapterProtocol {
    var service: NetworkingSiteServiceProtocol { get set }
    func fetchWeather(completion: @escaping((ResultChallenge<WeatherResponse, Error>) -> Void))
}

protocol NetworkingSiteRouterProtocol {
    associatedtype Router: NetworkRouter
    var router: Router { get set }
}

protocol NetworkingSiteServiceProtocol {
    func fetchWeather(completion: @escaping NetworkRouterCompletion)
}
