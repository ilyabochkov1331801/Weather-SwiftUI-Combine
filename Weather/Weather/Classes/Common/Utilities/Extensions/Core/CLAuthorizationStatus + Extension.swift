//
//  CLAuthorizationStatus + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import CoreLocation
import Foundation

extension CLAuthorizationStatus {
    var map: Permission.Status {
        switch self {
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        case .authorizedAlways: return .authorizedAlways
        case .authorizedWhenInUse: return .authorizedWhenInUse
        @unknown default: return .unknown
        }
    }
}
