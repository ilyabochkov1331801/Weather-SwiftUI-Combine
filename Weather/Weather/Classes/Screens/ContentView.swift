//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Text("\(viewModel.forecast?.city.name ?? "")")
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
        
        @Published var forecast: Forecast? {
            didSet {
                getDailyWeather()
            }
        }
        @Published var dailyWeather: [(Double, Date)]?
        
        init(weatherService: WeatherService) {
            self.weatherService = weatherService
            cancelBag = CancelBag()
        }
        
        func showForecast() {
            weatherService
                .getDailyWeather()
                .map { $0 }
                .eraseToAnyPublisher()
                .replaceError(with: nil)
                .assign(to: \.forecast, on: self)
                .store(in: cancelBag)
        }
        
        func getDailyWeather() {
            guard let temp = (forecast?.weather.map { array in
                array.info.temperature
            }), let dates = (forecast?.weather.map { array in
                array.date
            }) else {
                return
            }
            dailyWeather = Array(zip(temp, dates))
        }
    }
}
