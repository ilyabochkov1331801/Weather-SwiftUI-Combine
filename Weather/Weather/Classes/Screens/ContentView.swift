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
                    CardPreview(city: $viewModel.city, currentWeather: $viewModel.currentWeather)
                        .onAppear {
                            viewModel.showForecast()
                        }
                        .padding()
//                    LineView(data: $viewModel.dailyWeather.unwrap() ?? .constant([]) , title: "Today", legend: "Weather each 3 hours",
//                             style: ChartStyle(backgroundColor: .clear, accentColor: Color(Asset.manatee.name), gradientColor: GradientColor(start: Color(Asset.malibu.name), end: Color(Asset.electricViolet.name)), textColor: .white, legendTextColor: Color(Asset.manatee.name), dropShadowColor: .clear))
//                        .frame(width: UIScreen.main.bounds.width - 50, height: 200, alignment: .center)
                }
                .offset(y: 100)
                
                BottomButton {
                    
                }
                .offset(y: UIScreen.main.bounds.height - 100)
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
        
        @Published var forecast: Forecast? {
            didSet {
                getDailyWeather()
                getCurrentWeather()
            }
        }
        @Published var city: City?
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
            dailyWeather = Array(zip(dates, temp))
        }
    }
}

//("00:00", -8.0),("03:00", 23.0),("06:00", 54.0),("09:00", 32.0),("12:00", 12.0),("15:00", 37.0),("18:00", -7.0),("21:00", 37.0),("24:00", 17.0)
