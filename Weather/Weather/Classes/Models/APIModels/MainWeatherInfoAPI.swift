//
//  MainWeatherInfoAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct MainWeatherInfoAPI: Codable {
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Int
    let seaLevel: Int
    let grandLevel: Int
    let humidity: Int
    let temperatureСoefficient: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grandLevel = "grnd_level"
        case humidity
        case temperatureСoefficient = "temp_kf"
    }
}

extension MainWeatherInfoAPI: AppConvertable {
    typealias Target = WeatherInfo
    
    func convert() -> AnyPublisher<Target, Never> {
        Just(
            Target(temperature: temperature,
                   feelsLike: feelsLike,
                   minTemperature: minTemperature,
                   maxTemperature: maxTemperature,
                   pressure: pressure,
                   humidity: humidity)
        )
        .eraseToAnyPublisher()
    }
}
