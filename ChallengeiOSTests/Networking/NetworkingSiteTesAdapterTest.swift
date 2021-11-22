//
//  NetworkingSiteTesAdapterTest.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 18/11/21.
//  Copyright (c) 2021 Oscar Sierra Z. All rights reserved.
//

import XCTest
@testable import ChallengeiOS

class NetworkingSiteAdapterTest: XCTestCase {
    private let jsonRequest = "requestWithHTTP"
    var sut: NetworkingSiteAdapter!
    
    override func setUp() {
        super.setUp()
        sut = NetworkingSiteAdapter()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_requestSuccess() {
        self.setupNetworkingSiteAdapter(file: jsonRequest, code: 200, error: nil)

        sut.fetchWeather { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

    func test_InitialRequestFailure() {
        self.setupNetworkingSiteAdapter(file: jsonRequest, code: 400, error: nil)

        sut.fetchWeather { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    private func setupNetworkingSiteAdapter(file: String = String(), code: Int, error: Error? = nil) {
        let router = MockRouter.shared.createMockSession(fromJsonFile: file, andStatusCode: code, andError: error, as: NetworkingSiteAPI.self)
        let service = NetworkingSiteRouter(router)
        sut = NetworkingSiteAdapter(service)
    }
    
    struct DummyData {
    }
}
