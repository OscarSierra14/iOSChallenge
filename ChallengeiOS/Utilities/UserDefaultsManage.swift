//
//  UserDefaultsManage.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    var keyEnvironmentConfigFileName: String { get }
    static var shared: UserDefaultsManagerProtocol { get }
    func setEnvironmentConfig(with name: String?)
    func deleteEnvironmentConfigName()
    func getEnvironmentConfigName() -> String?
}

enum UserDefaultsManagerError: Error {
    case notExistData
    case notDecodeData
    case notParseData
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    static var shared: UserDefaultsManagerProtocol {
        return UserDefaultsManager()
    }
    
    let keyEnvironmentConfigFileName: String = "EnvironmentConfigFileName"
    var keyDeviceIdentifier: String = "currentDeviceIdentifier"
}


extension UserDefaultsManagerProtocol {
    func load<T: Decodable> (data: Data?, as type: T.Type = T.self) throws -> T {

        guard let data = data else {
            throw UserDefaultsManagerError.notDecodeData
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw UserDefaultsManagerError.notParseData
        }
    }
}

extension UserDefaultsManager {
    func setEnvironmentConfig(with name: String?) {
        if let fileName = name, !fileName.elementsEqual(Environment.ConfigFile.develop.rawValue) {
            UserDefaults.standard.set(fileName, forKey: keyEnvironmentConfigFileName)
        } else {
            deleteEnvironmentConfigName()
        }
    }

    func deleteEnvironmentConfigName() {
        UserDefaults.standard.removeObject(forKey: keyEnvironmentConfigFileName)
    }

    func getEnvironmentConfigName() -> String? {
        return UserDefaults.standard.string(forKey: keyEnvironmentConfigFileName)
    }
}
