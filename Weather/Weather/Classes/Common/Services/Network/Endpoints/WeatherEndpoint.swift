//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation

enum WeatherEndpoint: EndpointProtocol {
    case getForecastWeather(latitude: Double, longtitude: Double)
    var scheme: String {
        return "https"
    }
    var host: String {
       return "api.openweathermap.org"
    }
    var path: String {
        switch self {
        case .getForecastWeather:
            return "/data/2.5" + "/forecast"
        }
    }
    var key: String {
        return "c2d3e894f8515e4d514e9b3b541e1881"
    }
    
    var params: [String : String] {
        switch self {
        case let .getForecastWeather(latitude: latitude, longtitude: longtitude):
            return ["lat": String(latitude), "lon": String(longtitude), "mode": "json", "units": "metric", "APPID": key]
        }
    }
}
