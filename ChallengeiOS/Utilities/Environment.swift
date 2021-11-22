//
//  Environment.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//


import UIKit

public enum Environment {
    
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_API_URL"
            static let mapsApiKey = "MAPS_API_KEY"
            static let googleClientKey = "CLIENT_ID"
        }
    }
    
    enum ConfigFile: String {
        case production = "ChallengeiOS"
        case develop = "ChallengeiOS-developer"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    private static var customEnvironmentConfig: [String: Any] {
        if let environmentName = UserDefaultsManager.shared.getEnvironmentConfigName(),
            let path = Bundle.main.path(forResource: environmentName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String : Any] {
            return dict
        } else {
            return Environment.infoDictionary
        }
    }
    
    static var baseUrl: String {
        guard let baseUrl = Environment.customEnvironmentConfig[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist file for this environment")
        }
        return baseUrl
    }
    
    static let mapsApiKey : String = {
        guard let mapsApiKey = Environment.infoDictionary[Keys.Plist.mapsApiKey] as? String else {
            fatalError("Maps Api Key is not set in plist file for this environment")
        }
        return mapsApiKey
    }()
    
    static let googleClientKey : String = {
        guard let googleClientKey = Environment.infoDictionary[Keys.Plist.googleClientKey] as? String else {
            fatalError("google Api Key is not set in plist file for this environment")
        }
        return googleClientKey
    }()
}
