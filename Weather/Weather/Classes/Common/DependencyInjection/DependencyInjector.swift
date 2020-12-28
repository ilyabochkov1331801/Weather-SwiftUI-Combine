//
//  DependencyInjector.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import SwiftUI

struct DependencyInjector: EnvironmentKey {
    let appState: Store<AppState>
    let dataManagers: DataManagers
    let services: Services
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DependencyInjector(appState: AppState(),
                                                      dataManagers: DataManagers(),
                                                      services: Services.stub)
    
    init(appState: Store<AppState>, dataManagers: DependencyInjector.DataManagers, services: Services) {
        self.appState = appState
        self.dataManagers = dataManagers
        self.services = services
    }
    
    init(appState: AppState, dataManagers: DependencyInjector.DataManagers, services: Services) {
        self.init(appState: Store(appState), dataManagers: dataManagers, services: services)
    }
}

extension EnvironmentValues {
    var dependencyInjector: DependencyInjector {
        get { self[DependencyInjector.self] }
        set { self[DependencyInjector.self] = newValue }
    }
}
