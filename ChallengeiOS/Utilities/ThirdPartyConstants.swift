//
//  ThirdPartyConstants.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation

struct ThirdPartyConstants {
    struct Google {
        static let MapsAPIKey = Environment.mapsApiKey
        static let ClientKey = Environment.googleClientKey
    }
    
    struct NotificationCenter {
        static let internetConnectionFailed = "InternetConnectionFailed"
    }
}
