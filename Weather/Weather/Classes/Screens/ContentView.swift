//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @State private var text: String = ""
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(text)
                .padding()
            Button("Tap") {
                viewModel.showForecast()
            }
        }
    }
    
    class ViewModel: ObservableObject {
        private let weatherService: WeatherService
        private let cancelBag: CancelBag
        
        init(weatherService: WeatherService) {
            self.weatherService = weatherService
            cancelBag = CancelBag()
        }
        
        func showForecast() {
            weatherService.getDailyWeather()
                .sink {
                    print($0)
                } receiveValue: {
                    print($0)
                }.store(in: cancelBag)
        }
    }
}
