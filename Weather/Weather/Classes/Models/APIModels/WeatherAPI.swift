//
//  WeatherAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct WeatherAPI: Codable {
    let date: Double
    let mainWeatherInfo: MainWeatherInfoAPI
    let weatherState: [WeatherStateAPI]
    let clouds: CloudsAPI
    let wind: WindAPI
    let visibility: Int
    let pop: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainWeatherInfo = "main"
        case weatherState = "weather"
        case clouds
        case wind
        case visibility
        case pop
    }
}

extension WeatherAPI: AppConvertable {
    typealias Target = Weather
    
    func convert() -> AnyPublisher<Target, Never> {
        mainWeatherInfo.convert()
            .map { Target(state: (weatherState.first?.state ?? "No info", weatherState.first?.icon ?? "No info"),
                          date: Date(timeIntervalSince1970: date),
                          info: $0,
                          wind: wind.speed) }
            .eraseToAnyPublisher()
    }
}
