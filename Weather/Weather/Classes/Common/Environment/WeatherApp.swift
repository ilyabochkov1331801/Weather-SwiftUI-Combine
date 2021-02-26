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
            CurrentWeatherView(
                router: CurrentWeatherViewRouter(isPresented: .constant(false)),
                viewModel: CurrentWeatherView.ViewModel(
                    container: appEnvironment.container,
                    weatherService: WeatherService(locationProvider: appEnvironment.container.providers.locationProvider,
                                                   apiProvider: appEnvironment.container.providers.apiProvider),
                    dateService: DateService()
                )
            )
        }
    }
}
