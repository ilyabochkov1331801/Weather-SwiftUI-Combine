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
        setupUI()
        viewModel.showForecast()
    }
    @State var trim: CGFloat = 0
    
    var menuButton: some View {
        Button(action: {
        }) {
            Image(Asset.menu.name)
                .resizable()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20) {
//                    CardPreview(city: $viewModel.forecast.binding(keyPath: \.city),
//                                currentWeather: $viewModel.forecast.binding(keyPath: \.weather))
//                        .padding()
                    LineView(data: $viewModel.dailyWeather, title: "Today", legend: "Weather each 3 hours",
                             style: ChartStyle(backgroundColor: .clear, accentColor: Color(Asset.manatee.name), gradientColor: GradientColor(start: Color(Asset.malibu.name), end: Color(Asset.electricViolet.name)), textColor: .white, legendTextColor: Color(Asset.manatee.name), dropShadowColor: .clear))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 200, alignment: .center)
                }
                .offset(y: 100)
                
                BottomButton {
                    viewModel.showForecast()
                }
                .offset(y: UIScreen.main.bounds.height - 100)
                .sheet(router)
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
        
        @Published var forecast: Forecast = .empty
        @Published var dailyWeather: [(String, Double)] = []
        
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
                .map { $0 }
                .eraseToAnyPublisher()
                .sink(receiveCompletion: {
                    print($0)
                }, receiveValue: {
                    self.forecast = $0
                })
                .store(in: cancelBag)
            
            $forecast
                .eraseToAnyPublisher()
                .map {
                    let dates = ($0.weather.map { array in
                        DateComponentsFormatter().string(from: Calendar.current.dateComponents([.hour, .minute], from: array.date)).unwrapped
                    })
                    
                    let temp = ($0.weather.map { array in
                        array.info.temperature
                    })
                    
                    if dates.count > 0 && temp.count > 0 {
                        return Array(zip(dates[0..<9], temp))
                    }
                    return Array(zip(dates, temp))
                }
                .assign(to: \.dailyWeather, on: self)
                .store(in: cancelBag)
        }
    }
}
