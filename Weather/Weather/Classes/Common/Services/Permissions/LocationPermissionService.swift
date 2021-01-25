//
//  LocationPermissionService.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import CoreLocation
import Foundation

class LocationPermissionService: PermissionService {
    private let appState: Store<AppState>
    private let openAppSettings: () -> Void
    
    init(appState: Store<AppState>, openAppSettings: @escaping () -> Void) {
        self.appState = appState
        self.openAppSettings = openAppSettings
    }
    
    func resolveStatus(for permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: permission)
        let currentStatus = appState[keyPath]
        guard currentStatus == .unknown else { return }
        let onResolve: (Permission.Status) -> Void = { [weak appState] status in
            appState?[keyPath] = status
        }
        switch permission {
        case .location:
            locationPermissionStatus(onResolve)
        }
    }
    
    func request(permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: permission)
        let currentStatus = appState[keyPath]
        guard currentStatus != .denied else {
            openAppSettings()
            return
        }
        switch permission {
        case .location:
            requestLocationPermission()
        }
    }
}

extension LocationPermissionService {
    func locationPermissionStatus(_ resolve: @escaping (Permission.Status) -> Void) {
        DispatchQueue.main.async {
            resolve(CLLocationManager.authorizationStatus().map)
        }
    }
    
    func requestLocationPermission() {
        CLLocationManager().requestWhenInUseAuthorization()
//        DispatchQueue.main.async {
//            self.appState[\.permissions.location] = isGranted ? .granted : .denied
//        }
    }
}
