//
//  LocationProviderProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Combine
import CoreLocation
import Foundation

protocol LocationProviderProtocol {
    var location: CLLocation? { get }
    
    func getCityInfo() -> AnyPublisher<String, Error>
    func askForPermission()
}
