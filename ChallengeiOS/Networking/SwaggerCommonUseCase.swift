//
//  SwaggerCommonUseCase.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation

struct CommonUseCase {
    struct TokenResponse: Codable {
        var idToken: String
        var refreshToken: String
        var accessToken: String?
    }
    
    struct UploadFiles {
        var data: Data
        var name: String
        var fileName: String
        var mimeType: String
    }
}
