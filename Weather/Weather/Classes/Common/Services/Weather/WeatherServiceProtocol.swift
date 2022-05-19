//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func getDailyWeather() -> AnyPublisher<WeatherEndpoint.EndpointData.Target, Error>
    func getDailyWeather(by city: String) -> AnyPublisher<WeatherEndpoint.EndpointData.Target, Error>
}
