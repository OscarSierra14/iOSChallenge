//
//  OAuthResponse.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation

struct OAuthUnauthorizedResponse: Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let oauthValues = try decoder.container(keyedBy: CodingKeys.self)
        message =  try oauthValues.decode(String.self, forKey: .message)
    }
}
