//
//  WeatherEntity.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

struct WeatherResponse: Codable {
    var list: [responseData]
}

struct responseData: Codable {
    var dt: Int
    var weather: [weatherResponse]
    var dt_txt: String
}

struct weatherResponse: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct WheatherDataTableView {
    let week: String?
    let icon: String?
    let description: String?
}
