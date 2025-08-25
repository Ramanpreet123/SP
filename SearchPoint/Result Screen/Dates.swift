//
//  Date.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 8/25/21.
//

import Foundation

class Dates {
    static func printDatesBetweenInterval(_ startDate: Date, _ endDate: Date) {
        var startDate = startDate
        let calendar = Calendar.current

        let fmt = DateFormatter()
        fmt.dateFormat = DateFormatters.yyyyMMddFormat

        while startDate <= endDate {
            print(fmt.string(from: startDate))
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
    }

    static func dateFromString(_ dateString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddFormat

        return dateFormatter.date(from: dateString)!
    }
}
