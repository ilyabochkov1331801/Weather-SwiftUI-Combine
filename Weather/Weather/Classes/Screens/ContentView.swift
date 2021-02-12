//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

protocol ContentRouterProtocol: Router {
    func presentTest()
    func presentSettings()
    func presentNext(weather: Binding<[Weather]>)
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
            router.presentSettings()
        }) {
            Image(Asset.menu.name)
                .resizable()
        }.sheet(router)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        CardPreview(city: $viewModel.city, currentWeather: $viewModel.currentWeather)
                            .onAppear {
                                viewModel.showForecast()
                            }
                            .padding(.horizontal)
                        LineView(data: $viewModel.dailyWeather.unwrap() ?? .constant([]) , title: "Today", legend: "Weather each 3 hours",
                                 style: ChartStyle(backgroundColor: .clear,
                                                   accentColor: Color(Asset.manatee.name),
                                                   gradientColor: GradientColor(start: Color(Asset.malibu.name),
                                                                                end: Color(Asset.electricViolet.name)),
                                                   textColor: .white,
                                                   legendTextColor: Color(Asset.manatee.name),
                                                   dropShadowColor: .clear))
                            .frame(width: UIScreen.main.bounds.width - 50, height: 200, alignment: .center)
                        BottomButton {
                            router.presentNext(weather: $viewModel.daily.unwrap() ?? .constant([]))
                        }
                        .offset(y: UIScreen.main.bounds.height / 5)
                        .sheet(router)
                    }
                    .offset(y: 100)
                }
                
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
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(font: FontFamily.Roboto.regular, size: 20.0).unwrapped]
    }
    
    class ViewModel: ObservableObject {
        private let weatherService: WeatherService
        private let dateService: DateService
        private let cancelBag: CancelBag
        
        @Published var forecast: Forecast? {
            didSet {
                getDailyWeather()
                getCurrentWeather()
                getArray()
            }
        }
        @Published var city: City?
        @Published var daily: [Weather]?
        @Published var currentWeather: Weather?
        @Published var dailyWeather: [(String, Double)]?
        
        init(weatherService: WeatherService, dateService: DateService) {
            self.weatherService = weatherService
            self.dateService = dateService
            cancelBag = CancelBag()
        }
        
        func getCurrentDate() -> String {
            dateService.getCurrentDate()
        }
        
        func getCurrentWeather() {
            currentWeather = forecast?.weather.first
        }
        
        func getArray() {
            daily = forecast?.weather
        }
        
        func getCity() {
            city = forecast?.city
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
                String(Calendar.current.component(.hour, from: array.date))
            }) else {
                return
            }
            if dates.count > 0 {
                dailyWeather = Array(zip(dates[0..<9], temp))
            } else {
                dailyWeather = Array(zip(dates, temp))
            }
        }
    }
}

//("00:00", -8.0),("03:00", 23.0),("06:00", 54.0),("09:00", 32.0),("12:00", 12.0),("15:00", 37.0),("18:00", -7.0),("21:00", 37.0),("24:00", 17.0)
