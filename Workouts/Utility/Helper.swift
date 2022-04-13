//
//  Helper.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import Foundation

class Helper{
    static func dateToString(date: Date) -> String {
        let parsed = date.get(.day, .month, .year)
        let now = Date().get(.day, .month, .year)
        if parsed == now {
            return "Today"
        }
        if parsed.day == now.day!-1 && parsed.month == now.month && parsed.year == now.year {
            return "Yesterday"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        return dateFormatter.string(from: date)
    }
}

