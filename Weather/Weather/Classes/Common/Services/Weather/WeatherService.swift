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
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    
    private var location: CLLocation?
    private var city: String?
    
    init() {
        self.location = locationManager.location
    }
    
    func getCityInfo(completion: @escaping (Result<String, Error>) -> Void) {
        guard let location = location else {
            completion(.failure(WeatherServiceErrors.locationNil))
            return
        }
        
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let placemark = placemark?.first,
                let city = placemark.locality else {
                completion(.failure(WeatherServiceErrors.placeMarkNil))
                return
            }
            
            completion(.success(city))
        }
    }
    
    func getDailyWeather() -> AnyPublisher<Data, Error> {
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled(), let location = location else {
            return Fail(error: WeatherServiceErrors.noLocationPermission)
                .eraseToAnyPublisher()
        }
        
        return apiProvider.getData(by: .getForecastWeather(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude))
            //.decode(type: <#T##Decodable.Protocol#>, decoder: <#T##TopLevelDecoder#>)
            .eraseToAnyPublisher()
    }
}
