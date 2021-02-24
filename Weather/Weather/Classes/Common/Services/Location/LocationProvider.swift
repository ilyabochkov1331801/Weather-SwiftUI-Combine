//
//  LocationProvider.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Combine
import CoreLocation
import Foundation

class LocationProvider: NSObject, LocationProviderProtocol {
    private let locationManager: CLLocationManager
    private let locationSubject: CurrentValueSubject<CLLocation?, Error>
    private var authorizationStatus: CLAuthorizationStatus?
    
    var location: AnyPublisher<CLLocation, Error> {
        locationSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    override init() {
        locationSubject = CurrentValueSubject<CLLocation?, Error>(nil)
        locationManager = CLLocationManager()
        
        super.init()
        
        authorizationStatus = locationManager.authorizationStatus
        try? startUpdatingLocation()
    }
    
    deinit {
        stopUpdatingLocation()
    }
}

extension LocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationSubject.send(locations.first)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.send(completion: .failure(error))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}

private extension LocationProvider {
    func askForPermissionIfNeed() throws {
        switch authorizationStatus {
        case .some(.authorizedAlways), .some(.authorizedWhenInUse): break
        case .denied: throw(LocationProvider.Errors.noLocationPermission)
        default: locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startUpdatingLocation() throws {
        locationManager.delegate = self
        try askForPermissionIfNeed()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
}

extension LocationProvider {
    enum Errors: Error, LocalizedError {
        case noLocationPermission
        
        var errorDescription: String? {
            switch self {
            case .noLocationPermission:
                return L10n.noLocationPermissionKey
            }
        }
    }
}
