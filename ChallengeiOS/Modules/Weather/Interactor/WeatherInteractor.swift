//
//  WeatherInteractor.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

class WeatherInteractor: WeatherInteractorProtocol {
    weak var presenter: WeatherInteractorOutputProtocol?
    var networkManager: NetworkingSiteAdapterProtocol? = NetworkingSiteAdapter()
    
    func requestWeather() {
        networkManager?.fetchWeather(completion: { [weak self] response in
            switch response {
            case let .success(response):

                let dataResponse = response.list.map({WheatherDataTableView(
                    week: $0.dt_txt.toDate()?.dayOfWeek,
                    icon: "http://openweathermap.org/img/wn/\($0.weather.first?.icon ?? "")@2x.png",
                    description: $0.weather.first?.description)})
                
                self?.presenter?.fetchWeatherSuccessResponse(data: (self?.removeDuplicateElements(wheather: dataResponse))!)

            case .failure(_):
                self?.presenter?.fetchWeatherFailureResponse()
            }
        })
    }
    
    func removeDuplicateElements(wheather: [WheatherDataTableView]?) -> [WheatherDataTableView] {
        guard let wheather = wheather else {
            return []
        }

        var uniquePosts = [WheatherDataTableView]()
        for post in wheather {
            if !uniquePosts.contains(where: {$0.week == post.week }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
}
