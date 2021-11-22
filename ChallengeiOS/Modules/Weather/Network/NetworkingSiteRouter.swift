//
//  NetworkingSiteRouter.swift
//  ChallengeiOS
//
//  Created by Oscar Eduardo Sierra Zuniga on 21/06/20.
//  Copyright (c) 2020 Oscar Sierra Z. All rights reserved.
//

import Foundation

class NetworkingSiteRouter<Router: NetworkRouter>: NetworkingSiteRouterProtocol, NetworkingSiteServiceProtocol where Router.EndPoint == NetworkingSiteAPI {
    var router: Router
    
    init(_ router: Router) {
        self.router = router
    }

    func fetchWeather(completion: @escaping NetworkRouterCompletion) {
        router.request(.fetchWeather) { data, response, error in
            completion(data, response, error)
        }
    }
}
