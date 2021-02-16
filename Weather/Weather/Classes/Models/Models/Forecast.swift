//
//  Forecast.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct Forecast {
    let city: City
    var weather: [Weather]
    
    static let empty: Forecast = Forecast(city: City(name: "No name", sunrise: Date(), sunset: Date()), weather: [])
}

extension Forecast: AppConvertableTarget { }
