//
//  WeatherApp.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        let appEnvironment = AppEnvironment.bootstrap()
        return WindowGroup {
            ContentView()
                .environment(\.dependencyInjector, appEnvironment.container)
        }
    }
}
