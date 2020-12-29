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
    let providers: Providers
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DependencyInjector(appState: AppState(),
                                                      providers: .stub)
    
    init(appState: Store<AppState>, providers: DependencyInjector.Providers) {
        self.appState = appState
        self.providers = providers
    }
    
    init(appState: AppState, providers: DependencyInjector.Providers) {
        self.init(appState: Store(appState), providers: providers)
    }
}

extension EnvironmentValues {
    var dependencyInjector: DependencyInjector {
        get { self[DependencyInjector.self] }
        set { self[DependencyInjector.self] = newValue }
    }
}
