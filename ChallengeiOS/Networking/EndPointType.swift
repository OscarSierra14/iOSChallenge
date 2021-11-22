//
//  EndPointType.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation
import Alamofire

public enum ChallengeiOSErrorType: Error {
    case noInternet
    case noRequest
    case errorService
    case badRequest
}

enum ResultChallenge<T,U> {
    case success(T)
    case failure(U)
}

enum GatewayAuthentication {
    case openOAuthService
    case loginService
    case communService
}

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var data: Data? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    private var environmentBaseURL: String {
        return Environment.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    func encode<T>(_ value: T) -> Data? where T : Encodable {
        do {
            let json = JSONEncoder()
            return try json.encode(value)
        } catch {
            return nil
        }
    }
}
