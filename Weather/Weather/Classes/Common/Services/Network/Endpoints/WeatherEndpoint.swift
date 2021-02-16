//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation

enum WeatherEndpoint: EndpointProtocol {
    case getForecastWeather(latitude: Double, longtitude: Double)
    case getForecastWeatherByCity(city: String)
    
    typealias EndpointData = ForecastAPI
    
    var path: String {
        return "/data/2.5" + "/forecast"
    }
    
    var params: [String : String] {
        switch self {
        case let .getForecastWeather(latitude: latitude, longtitude: longtitude):
            return ["lat": String(latitude), "lon": String(longtitude), "mode": "json", "units": "metric", "APPID": key]
        case let .getForecastWeatherByCity(city: city):
            return ["q": city, "mode": "json", "units": "metric", "APPID": key]
        }
    }
}

extension WeatherEndpoint {
    var scheme: String { "https" }
    var host: String { "api.openweathermap.org" }
    var key: String { "100e5cd0e66c14f38fe84bd7d566d702" }
}
