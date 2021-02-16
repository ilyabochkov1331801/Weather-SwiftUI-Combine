//
//  AppState.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import UIKit

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()
}

extension AppState {
    struct UserData: Equatable {
        
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        
    }
}

extension AppState {
    struct System: Equatable {
        static var units: AppEnvironment.WeatherUnits = .degrees
    }
}

extension AppState {
    struct Permissions: Equatable {
        var location: Permission.Status = .unknown
    }
    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .location:
            return pathToPermissions.appending(path: \.location)
        }
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions
}
