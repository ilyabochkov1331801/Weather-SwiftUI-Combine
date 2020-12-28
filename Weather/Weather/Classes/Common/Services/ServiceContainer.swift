//
//  ServiceContainer.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

extension DependencyInjector {
    struct Services {
        let weatherService: WeatherServiceProtocol
        
        init(weatherService: WeatherServiceProtocol) {
            self.weatherService = weatherService
        }
        
        static var stub: Self {
            .init(weatherService: WeatherService(locationProvider: LocationProvider()))
        }
    }
}
