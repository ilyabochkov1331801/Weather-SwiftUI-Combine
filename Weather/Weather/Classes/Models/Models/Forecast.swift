//
//  Forecast.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct Forecast {
    let city: City
    let weather: [Weather]
}

extension Forecast: AppConvertableTarget { }
