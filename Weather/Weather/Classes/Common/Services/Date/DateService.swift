//
//  DateService.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import Foundation

class DateService: DateServiceProtocol {
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
}
