//
//  LocationProviderProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Combine
import CoreLocation
import Foundation

protocol LocationProviderProtocol: NSObject {
    var location: AnyPublisher<CLLocation, Error> { get }
}
