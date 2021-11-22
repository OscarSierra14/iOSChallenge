//
//  NetworkingSiteAdapter.swift
//  ChallengeiOS
//
//  Created by Oscar Eduardo Sierra Zuniga on 21/06/20.
//  Copyright (c) 2020 Oscar Sierra Z. All rights reserved.
//

import Foundation

class NetworkingSiteAdapter: DefaultNetworkManager, NetworkingSiteAdapterProtocol {
    var service: NetworkingSiteServiceProtocol
    
    init(_ service: NetworkingSiteServiceProtocol = NetworkingSiteRouter(RouterChallenge<NetworkingSiteAPI>())) {
        self.service = service
    }

    func fetchWeather(completion: @escaping ((ResultChallenge<WeatherResponse, Error>) -> Void)) {
        service.fetchWeather { data, response, error in
            if let response = response {
                let result = self.handleNetwork(response)
                switch result {
                case .success:
                    do {
                        let response: WeatherResponse = try self.load(data: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    enum ErrorType: Error, LocalizedError {
        case unauthorized
        case notFound
        case failed
        
        var errorDescription: String? {
            return "Error"
        }
    }
    
    override func handleNetwork(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299: return .success
        default: return .failure(ErrorType.failed)
        }
    }
}
