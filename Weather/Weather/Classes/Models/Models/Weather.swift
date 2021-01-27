//
//  Weather.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

typealias Deegrees = Double

struct Weather {
    let state: String
    let date: Date
    let info: WeatherInfo
    let wind: Double
}

extension Weather: AppConvertableTarget { }
