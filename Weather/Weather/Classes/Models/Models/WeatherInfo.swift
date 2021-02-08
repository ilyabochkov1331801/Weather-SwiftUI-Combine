//
//  WeatherInfo.swift
//  Weather
//
//  Created by Alena Nesterkina on 27.01.21.
//

import Foundation

struct WeatherInfo {
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Int
    let humidity: Int
}

extension WeatherInfo: AppConvertableTarget { }
