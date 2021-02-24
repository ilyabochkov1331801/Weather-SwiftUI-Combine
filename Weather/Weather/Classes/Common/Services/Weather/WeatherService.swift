//
//  WeatherService.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import CoreLocation
import Foundation
import Combine

class WeatherService: WeatherServiceProtocol {
    private let apiProvider: APIProvider
    private let locationProvider: LocationProvider
    
    init(locationProvider: LocationProvider, apiProvider: APIProvider) {
        self.locationProvider = locationProvider
        self.apiProvider = apiProvider
    }
    
    func getDailyWeather() -> AnyPublisher<WeatherEndpoint.EndpointData.Target, Error> {
        locationProvider
            .location
            .flatMap {
                self.apiProvider.execute(
                    endpoint: WeatherEndpoint.getForecastWeather(
                        latitude: $0.coordinate.latitude,
                        longtitude: $0.coordinate.longitude
                    )
                )
            }
            .eraseToAnyPublisher()
    }
    
    func getDailyWeather(by city: String) -> AnyPublisher<WeatherEndpoint.EndpointData.Target, Error> {
        apiProvider.execute(endpoint: WeatherEndpoint.getForecastWeatherByCity(city: city))
            .eraseToAnyPublisher()
    }
}

extension WeatherService {
    enum Errors: Error, LocalizedError {
        case locationNil
        
        var errorDescription: String? {
            switch self {
            case .locationNil:
                return L10n.locationNilKey
            }
        }
    }
}
