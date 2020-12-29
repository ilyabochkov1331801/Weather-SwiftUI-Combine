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
        startUpdatingLocation()
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
    func askForPermissionIfNeed() {
        switch authorizationStatus {
        case .some(.authorizedAlways), .some(.authorizedWhenInUse): break
        default: locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        askForPermissionIfNeed()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
}
