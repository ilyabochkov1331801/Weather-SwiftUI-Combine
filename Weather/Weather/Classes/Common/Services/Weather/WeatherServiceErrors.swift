//
//  WeatherServiceErrors.swift
//  Weather
//
//  Created by Alena Nesterkina on 9.12.20.
//

import Foundation

enum WeatherServiceErrors: Error {
    case noLocationPermission
    case locationNil
    case placeMarkNil
}

extension WeatherServiceErrors: LocalizedError {
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
