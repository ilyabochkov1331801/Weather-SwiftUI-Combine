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
            ContentView(
                viewModel: ContentView.ViewModel(
                    weatherService: WeatherService(locationProvider: appEnvironment.container.providers.locationProvider,
                                                   apiProvider: appEnvironment.container.providers.apiProvider)
                )
            )
            .environment(\.dependencyInjector, appEnvironment.container)
        }
    }
}
