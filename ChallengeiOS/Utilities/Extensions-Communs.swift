//
//  Extensions-Communs.swift
//  ChallengeiOS
//
//  Created by Oscar Sierra on 21/11/21.
//  Copyright © 2021 Oscar Sierra Z. All rights reserved.
//

import UIKit

extension Date {
    var dayOfWeek: String {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.weekdaySymbols[calendar.component(.weekday, from: self) - 1]
    }
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
