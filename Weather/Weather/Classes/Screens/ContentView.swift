//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import Combine
import SwiftUI

protocol ContentRouterProtocol: Router {
    func presentSettings(city: Binding<String>, updateForecast: Binding<Void>)
    func presentNext(weather: Binding<[Weather]>)
}

struct ContentView<Router: ContentRouterProtocol>: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @StateObject var viewModel: ViewModel
    @StateObject private var router: Router
    
    init(router: Router, viewModel: ViewModel) {
        _router = StateObject(wrappedValue: router)
        _viewModel = StateObject(wrappedValue: viewModel)
        setupUI()
        
        viewModel.showForecast()
    }
    @State var trim: CGFloat = 0
    
    var menuButton: some View {
        Button(action: {
            router.presentSettings(city: $viewModel.city.name,
                                   updateForecast: $viewModel.updateForecast)
        }) {
            Image(Asset.menu.name)
                .resizable()
        }
        .sheet(router)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        CardPreview(city: $viewModel.city, currentWeather: $viewModel.currentWeather)
                            .padding(.horizontal)
                        
                        LineView(data: $viewModel.hourlyWeather, title: "Today", legend: "Weather each 3 hours",
                                 style: ChartStyle(backgroundColor: .clear,
                                                   accentColor: Color(Asset.manatee.name),
                                                   gradientColor: GradientColor(start: Color(Asset.malibu.name),
                                                                                end: Color(Asset.electricViolet.name)),
                                                   textColor: .white,
                                                   legendTextColor: Color(Asset.manatee.name),
                                                   dropShadowColor: .clear))
                            .frame(width: UIScreen.main.bounds.width - 30, height: 200, alignment: .center)
                        
                        HStack(alignment: .center) {
                            BottomButton {
                                router.presentNext(weather: $viewModel.dailyWeather)
                            }
                            .offset(y: UIScreen.main.bounds.height / 5)
                            .sheet(router)
                            
                            Button(action: {
                                viewModel.showForecast()
                            }, label: {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(.white)
                            })
                            .offset(y: UIScreen.main.bounds.height / 5 )
                        }
                    }
                    .offset(y: 100)
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Today \(viewModel.currentDate())", displayMode: .inline)
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
        
        @Published var forecast: Forecast = .empty
        @Published var city: City = .empty
        @Published var currentWeather: Weather = .empty
        @Published var hourlyWeather: [(String, Double)] = []
        @Published var dailyWeather: [Weather] = []
        @Published var updateForecast: Void = ()
        @Published var updateUnits: AppEnvironment.WeatherUnits = .degrees
        
        init(weatherService: WeatherService, dateService: DateService) {
            self.weatherService = weatherService
            self.dateService = dateService
            cancelBag = CancelBag()
            
            setCurrentWeatherPublisher()
            setHourlySelectionPublisher()
            setDailyWeatherPublisher()
            setCityPublisher()
            
            $updateForecast
                .eraseToAnyPublisher()
                .sink {
                    print($0)
                } receiveValue: { [weak self] in
                    guard let self = self else { return }
                    self.showForecast(by: self.city.name)
                }
                .store(in: cancelBag)
            
            $updateUnits
                .eraseToAnyPublisher()
                .sink {
                    print($0)
                } receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    if self.forecast.city.name != "No name" {
                        self.convert(to: self.updateUnits)
                    }
                }
                .store(in: cancelBag)
        }
        
        func currentDate() -> String {
            dateService.getCurrentDate()
        }
        
        func convert(to units: AppEnvironment.WeatherUnits) {
            $forecast
                .eraseToAnyPublisher()
                .sink(receiveCompletion: {
                    print($0)
                }, receiveValue: {
                    var buffer = $0
                    buffer.weather.changeEach { item in
                        if units == .degrees {
                            item.info.feelsLike.toDegrees()
                            item.info.temperature.toDegrees()
                            item.info.minTemperature.toDegrees()
                            item.info.maxTemperature.toDegrees()
                        } else {
                            item.info.feelsLike.toFarengheit()
                            item.info.temperature.toFarengheit()
                            item.info.minTemperature.toFarengheit()
                            item.info.maxTemperature.toFarengheit()
                        }
                    }
                    self.forecast = buffer
                })
                .store(in: cancelBag)
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
        }
        
        func showForecast(by city: String) {
            weatherService
                .getDailyWeather(by: city)
                .map { $0 }
                .eraseToAnyPublisher()
                .sink(receiveCompletion: {
                    print($0)
                }, receiveValue: {
                    self.forecast = $0
                })
                .store(in: cancelBag)
        }
        
        func setCurrentWeatherPublisher() {
            $forecast
                .eraseToAnyPublisher()
                .map { item in
                    guard let weather = item.weather.first else { return Weather.empty }
                    return weather
                }
                .assign(to: \.currentWeather, on: self)
                .store(in: cancelBag)
        }
        
        func setHourlySelectionPublisher() {
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
                .assign(to: \.hourlyWeather, on: self)
                .store(in: cancelBag)
        }
        
        func setCityPublisher() {
            $forecast
                .eraseToAnyPublisher()
                .map { $0.city }
                .assign(to: \.city, on: self)
                .store(in: cancelBag)
        }
        
        func setDailyWeatherPublisher() {
            $forecast
                .eraseToAnyPublisher()
                .map { Array($0.weather.dropFirst()) }
                .assign(to: \.dailyWeather, on: self)
                .store(in: cancelBag)
        }
    }
}
