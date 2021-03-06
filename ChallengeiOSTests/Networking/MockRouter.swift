//
//  NetworkingSiteTesAdapterTest.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import XCTest
@testable import ChallengeiOS

class MockRouterChallenge<EndPoint: EndPointType>: NetworkRouter {
    var completionHandler: (Data?, HTTPURLResponse?, Error?)
    private var printEndPointData: Bool = false
    init(completionHandler: (Data?, HTTPURLResponse?, Error?), printEndPointData: Bool = false) {
        self.printEndPointData = printEndPointData
        self.completionHandler = completionHandler
    }

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        self.printEnpointInformation(route)
        completion(self.completionHandler.0, self.completionHandler.1, self.completionHandler.2)
    }

    func upload(_ route: EndPoint, arrayFiles: [CommonUseCase.UploadFiles], completion: @escaping NetworkRouterCompletion) {
        self.printEnpointInformation(route)
        completion(self.completionHandler.0, self.completionHandler.1, self.completionHandler.2)
    }

    private func printEnpointInformation(_ route: EndPoint) {
        if printEndPointData {
            print("\n\n\n\tš -START- š" +
                "\nš -\(String(describing: route.self))- š" +
                "\nš PATH: \(route.path) š" +
                self.printData(data: route.data) +
                "\nš HTTPMethod: \(route.httpMethod) š" +
                "\nš Parameters: \(String(describing: route.parameters)) š" +
                "\nš HTTPHeaders: \(String(describing: route.headers)) š" +
                "\n\tš -END- š\n\n\n")
        }
    }

    private func printData(data: Data?) -> String {
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            return "\nš DATA JSON: \(json) š"
        }
        return String()
    }
}

class MockRouter {

    static var shared = MockRouter()

    private init() {}

    private func loadJsonData(file: String) -> Data? {
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }

    func createMockSession<T: EndPointType>(fromJsonFile file: String = String(),
                                            andStatusCode code: Int,
                                            andError error: Error? = nil, as type: T.Type = T.self) -> MockRouterChallenge<T> {

        let data = file.isEmpty ? nil : loadJsonData(file: file)
        let response = HTTPURLResponse(
            url: URL(string: "TESTUrl")!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil)
        return MockRouterChallenge<T>(completionHandler: (data, response, error), printEndPointData: true)
    }
}
