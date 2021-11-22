//
//  DefaultNetworkManager.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

enum Result<T> {
    case success
    case failure(T)
}

protocol DefaultNetworkManagerProtocol {
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Error>
}

class DefaultNetworkManager: DefaultNetworkManagerProtocol {
    
    enum DefaultErrorType: Error, LocalizedError {
        case notDecodeData
        case notParseData
        case failed
        
        var errorDescription: String? {
            return "Service Fail"
        }
    }
    
    func load<T: Decodable> (data: Data?, as type: T.Type = T.self) throws -> T {
        guard let data = data else { throw DefaultErrorType.notDecodeData }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            Log.e("ERROR PARSE DATA: \(error)")
            throw DefaultErrorType.notParseData
        }
    }
    
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299: return .success
        default: return .failure(DefaultErrorType.failed)
        }
    }
}
