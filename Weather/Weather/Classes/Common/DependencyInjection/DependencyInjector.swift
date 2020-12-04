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
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DependencyInjector(appState: AppState(),
                                                      dataManagers: DataManagers())
    
    init(appState: Store<AppState>, dataManagers: DependencyInjector.DataManagers) {
        self.appState = appState
        self.dataManagers = dataManagers
    }
    
    init(appState: AppState, dataManagers: DependencyInjector.DataManagers) {
        self.init(appState: Store(appState), dataManagers: dataManagers)
    }
}

extension EnvironmentValues {
    var dependencyInjector: DependencyInjector {
        get { self[DependencyInjector.self] }
        set { self[DependencyInjector.self] = newValue }
    }
}
