//
//  WeatherInfo.swift
//  Weather
//
//  Created by Alena Nesterkina on 27.01.21.
//

import Foundation

struct WeatherInfo: Hashable {
    var temperature: Double
    var feelsLike: Double
    var minTemperature: Double
    var maxTemperature: Double
    let pressure: Int
    let humidity: Int
    
    static let empty: WeatherInfo = WeatherInfo(temperature: 0,
                                                feelsLike: 0,
                                                minTemperature: 0,
                                                maxTemperature: 0,
                                                pressure: 0,
                                                humidity: 0)
}

extension WeatherInfo: AppConvertableTarget { }
