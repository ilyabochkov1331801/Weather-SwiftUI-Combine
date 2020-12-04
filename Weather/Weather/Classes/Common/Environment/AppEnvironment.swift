//
//  AppEnvironment.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine

struct AppEnvironment {
    let container: DependencyInjector
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        AppEnvironment(container: DependencyInjector(appState: AppState(),
                                                     dataManagers: DependencyInjector.DataManagers()))
    }
}
