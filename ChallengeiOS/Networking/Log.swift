//
//  Log.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

enum DateFormatterType {
    case fullDate

    var path: String {
        switch self {
        case .fullDate:
            return "dd/MM/YYY HH:mm:ss"
        }
    }
}

final class Log: LogProtocol {
    static func e(_ object: Any, filename: String = #file, functionName: String = #function) {
        print("\(Date().toString()) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]: \(functionName) ->", with: object)
    }
    
    static func d(_ object: Any, filename: String = #file, functionName: String = #function) {
        print("\(Date().toString()) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]: \(functionName) ->", with: object)
    }
    
    static func w(_ object: Any, filename: String = #file, functionName: String = #function) {
        print("\(Date().toString()) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]: \(functionName) ->", with: object)
    }
}

extension LogProtocol {
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterType.fullDate.path
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static func print(_ info: String, with object: Any) {
        if isLoggingEnabled {
            Swift.print(info, object)
        }
    }
    
    static func sourceFileName(filePath: String) -> String {
        return FileManager.default.displayName(atPath: filePath)
    }
}

protocol LogProtocol {
    // Log error message
    static func e(_ object: Any, filename: String, functionName: String)
    
    // Log debug message
    static func d(_ object: Any, filename: String, functionName: String)
    
    // Log warning message
    static func w(_ object: Any, filename: String, functionName: String)
}

enum LogEvent: String {
    case e = "[‼️]" // error
    case d = "[💬]" // debug
    case w = "[⚠️]" // warning
}
