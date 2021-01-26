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
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        setupUI()
    }
    
    var menuButton: some View {
        Button(action: {
            
        }) {
            Image(Asset.menu.name)
                .resizable()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                CardPreview()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Today \(viewModel.getCurrentDate())", displayMode: .inline)
            .navigationBarItems(trailing: menuButton)
        }
    }
    
    func setupUI() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Asset.midGray.color, .font: UIFont(font: FontFamily.Roboto.regular, size: 20.0).unwrapped]
    }
    
    class ViewModel: ObservableObject {
        private let weatherService: WeatherService
        private let dateService: DateService
        private let cancelBag: CancelBag
    
        @Published var weather: Weather?
        
        init(weatherService: WeatherService, dateService: DateService) {
            self.weatherService = weatherService
            self.dateService = dateService
            cancelBag = CancelBag()
        }
        
        func getCurrentDate() -> String {
            dateService.getCurrentDate()
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
