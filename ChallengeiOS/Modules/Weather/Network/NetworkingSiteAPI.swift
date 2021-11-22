//
//  NetworkingSiteAPI.swift
//  ChallengeiOS
//
//  Created by Oscar Eduardo Sierra Zuniga on 21/06/20.
//  Copyright (c) 2020 Oscar Sierra Z. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkingSiteAPI {
    case fetchWeather
}

extension NetworkingSiteAPI: EndPointType {
    var headers: HTTPHeaders? {
        return nil
    }

    var path: String {
        switch self {
        default:
            return ""
        }
    }

    var data: Data? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
}
