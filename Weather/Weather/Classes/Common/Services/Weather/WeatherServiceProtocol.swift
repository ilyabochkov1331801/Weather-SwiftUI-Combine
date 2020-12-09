//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func getCityInfo(completion: @escaping (Result<String, Error>) -> Void)
    func getDailyWeather() -> AnyPublisher<Data, Error>
}
