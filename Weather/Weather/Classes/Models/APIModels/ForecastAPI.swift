//
//  ForecastAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct ForecastAPI: Codable {
    let city: CityAPI
    let weather: [WeatherAPI]
    let code: String
    let message: Int
    let cnt: Int
    
    enum CodingKeys: String, CodingKey {
        case city
        case weather = "list"
        case code = "cod"
        case message
        case cnt
    }
}

extension ForecastAPI: AppConvertable {
    typealias Target = Forecast
    
    func convert() -> AnyPublisher<Target, Never> {
        weather.publisher
            .flatMap { $0.convert() }
            .collect()
            .combineLatest(city.convert())
            .map { Forecast(city: $1, weather: $0) }
            .eraseToAnyPublisher()
    }
}
