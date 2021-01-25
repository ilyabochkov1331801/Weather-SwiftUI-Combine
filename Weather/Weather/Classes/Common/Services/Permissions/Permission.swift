//
//  Permission.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Foundation

enum Permission {
    case location
}

extension Permission {
    enum Status: Equatable {
        case unknown
        case notDetermined, restricted, denied
        case authorizedAlways, authorizedWhenInUse
    }
}
