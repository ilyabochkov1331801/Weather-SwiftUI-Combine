//
//  LocationProvider.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Combine
import CoreLocation
import Foundation

class LocationProvider: LocationProviderProtocol {
    private let geoCoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    var location: CLLocation?
    
    init() {
        self.location = locationManager.location
        startUpdatingLocation()
    }
    
    deinit {
        stopUpdatingLocation()
    }
    
    func getCityInfo() -> AnyPublisher<String, Error> {
        guard let location = location else {
            return Fail(error: WeatherService.Errors.locationNil)
                .eraseToAnyPublisher()
        }

        return reverseGeocodeLocation(location)
            .eraseToAnyPublisher()
    }
    
    func askForPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationProvider {
    private func reverseGeocodeLocation(_ location: CLLocation) -> Future<String, Error> {
        return Future { promise in
            self.geoCoder.reverseGeocodeLocation(location ) { placemarks, error in
                if let error = error {
                    return promise(.failure(error))
                }
                
                guard let placemark = placemarks?.first,
                      let city = placemark.locality else {
                    return promise(.failure(WeatherService.Errors.placeMarkNil))
                }
                return promise(.success(city))
            }
        }
    }
}

extension LocationProvider {
    func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
