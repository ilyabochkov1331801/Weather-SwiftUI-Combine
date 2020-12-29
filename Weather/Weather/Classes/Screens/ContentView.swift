//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Text(viewModel.weather.debugDescription)
                    .padding()
                Button("Tap") {
                    viewModel.showForecast()
                }
            }
        }
    }
    
    class ViewModel: ObservableObject {
        private let weatherService: WeatherService
        private let cancelBag: CancelBag
    
        @Published var weather: Weather?
        
        init(weatherService: WeatherService) {
            self.weatherService = weatherService
            cancelBag = CancelBag()
        }
        
        func showForecast() {
            weatherService
                .getDailyWeather()
                .map { $0.weather.first }
                .eraseToAnyPublisher()
                .replaceError(with: nil)
                .assign(to: \.weather, on: self)
                .store(in: cancelBag)
        }
    }
}
