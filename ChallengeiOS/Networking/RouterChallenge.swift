//
//  RouterChallengeiOS.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Alamofire

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: HTTPURLResponse?,_ error: Error?) -> Void

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

class RouterChallenge<EndPoint: EndPointType>: NetworkRouter {
    let sessionManager = Alamofire.SessionManager.default

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        if !Reachability.isConnectedToNetwork(){
            showFailInternetConnection()
            return
        }

        setupInterceptor(route) {(data, response, error) in
                completion(data, response, error)
        }
    }

    func requestInterceptor(urlRequest: URLRequest, completion: @escaping NetworkRouterCompletion) {
        sessionManager.request(urlRequest).responseData { response in
            Log.d("STATUS RESPONSE -> \(String(describing: response.response?.statusCode))")
            self.validateServiceResponse(response: response, completion: { (data, response, error) in
                completion(data, response, error)
            })
        }
    }

    func successPrintResponse(data: Data) {
        if let body = try?  JSONSerialization.jsonObject(with: data, options: []) {
            Log.d("Success Response -> \(body)")
        }
    }

    func showFailInternetConnection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            NotificationCenter.default.post(name: Notification.Name(ThirdPartyConstants.NotificationCenter.internetConnectionFailed), object: nil)
        }
    }

    func setupInterceptor(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let fullURL = route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding
        var urlRequest = URLRequest(url: URL(string: fullURL ?? String()) ?? route.baseURL.appendingPathComponent(route.path))
        urlRequest.httpMethod = route.httpMethod.rawValue
        urlRequest.httpBody = route.httpMethod == .get ? nil : route.data
        urlRequest.allHTTPHeaderFields = route.headers
        if let url = urlRequest.urlRequest?.url {
            Log.d("HEADERS -> \(route.headers ?? HTTPHeaders())")
            Log.d("URL REQUEST -> \(url)")
        }

        do {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: route.parameters)
        } catch {
            completion(nil, nil, error)
        }

        sessionManager.session.configuration.timeoutIntervalForRequest = 120
        sessionManager.session.configuration.timeoutIntervalForResource = 120

        if let body = try?  JSONSerialization.jsonObject(with: route.data ?? Data(), options: []) {
            Log.d("BODY -> \(body)")
        }

        requestInterceptor(urlRequest: urlRequest) { (data, response, error) in
            completion(data, response, error)
        }
    }
    
    private func validateServiceResponse(response: DataResponse<Data>, completion: @escaping NetworkRouterCompletion) {
        switch response.result {
        case .success(let data):
            self.successPrintResponse(data: data)
            completion(data, response.response, nil)
            
        case .failure(let error):
            completion(nil, nil, error)
        }
    }
}

