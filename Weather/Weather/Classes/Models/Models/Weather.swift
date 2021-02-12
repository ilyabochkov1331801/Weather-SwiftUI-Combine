//
//  Weather.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

typealias Deegrees = Double

struct Weather: Hashable {
    let state: String
    let date: Date
    let info: WeatherInfo
    let wind: Double
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

extension Weather: AppConvertableTarget { }
