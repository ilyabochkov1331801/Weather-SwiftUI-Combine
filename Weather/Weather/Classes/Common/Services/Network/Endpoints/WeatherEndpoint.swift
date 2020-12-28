//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation

enum WeatherEndpoint: EndpointProtocol {
    case getForecastWeather(latitude: Double, longtitude: Double)
    
    typealias EndpointData = ForecastAPI
    
    var path: String {
        switch self {
        case .getForecastWeather:
            return "/forecast"
        }
    }
    
    var params: [String : String] {
        switch self {
        case let .getForecastWeather(latitude: latitude, longtitude: longtitude):
            return ["lat": String(latitude), "lon": String(longtitude), "mode": "json", "units": "metric", "APPID": key]
        }
    }
}

extension WeatherEndpoint {
    var scheme: String { "https" }
    var host: String { "api.openweathermap.org/data/2.5" }
    var key: String { "c2d3e894f8515e4d514e9b3b541e1881" }
}
