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
    private let apiProvider = APIProvider<WeatherEndpoint>()
    private var city: String?
    
    let locationProvider: LocationProvider
    
    init(locationProvider: LocationProvider) {
        self.locationProvider = locationProvider
    }
    
    func getDailyWeather() -> AnyPublisher<WeatherEndpoint.EndpointData.Target, Error> {
        guard CLLocationManager.locationServicesEnabled(),
              let location = locationProvider.locationManager.location else {
            return Fail(error: WeatherService.Errors.noLocationPermission)
                .eraseToAnyPublisher()
        }
        return apiProvider.getData(by: .getForecastWeather(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude))
    }
}

extension WeatherService {
    enum Errors: Error, LocalizedError {
        case noLocationPermission
        case locationNil
        case placeMarkNil
        
        var errorDescription: String? {
            switch self {
            case .noLocationPermission:
                return L10n.noLocationPermissionKey
            case .locationNil:
                return L10n.locationNilKey
            case .placeMarkNil:
                return L10n.placeMarkNil
            }
        }
    }
}
