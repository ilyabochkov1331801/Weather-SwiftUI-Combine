//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

protocol ContentRouterProtocol: Router {
    func presentTest()
}

struct ContentView<N: ContentRouterProtocol>: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @StateObject var viewModel: ViewModel
    @StateObject private var router: N
    
    init(router: N, viewModel: ViewModel) {
        _router = StateObject(wrappedValue: router)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text(viewModel.weather.debugDescription)
                        .padding()
                    Button("Tap") {
                        viewModel.showForecast()
                    }
                    Button("Go Next") {
                        router.presentTest()
                    }.navigation(router)
                }
            }
            .navigationTitle("Main")
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
