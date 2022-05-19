//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.02.21.
//

import Combine
import SwiftUI

extension CurrentWeatherView {
    class ViewModel: ObservableObject {
        let container: DependencyInjector
        
        private let weatherService: WeatherService
        private let dateService: DateService
        private let cancelBag: CancelBag
        
        @Published var forecast: Forecast = .empty
        @Published var city: City = .empty
        @Published var currentWeather: Weather = .empty
        @Published var hourlyWeather: [(String, Double)] = []
        @Published var dailyWeather: [Weather] = []
        @Published var updateForecast: Void = ()
        @Published var error: (Error, Bool) = (NSError(), false)
        
        var onChangeHandler: () -> Void {
            return {
                if self.forecast.city.name != "No name" {
                    var buffer = self.forecast
                    buffer.weather.changeEach { item in
                        if self.container.appState.value.system.units == .degrees {
                            item.info.feelsLike.toDegrees()
                            item.info.temperature.toDegrees()
                            item.info.minTemperature.toDegrees()
                            item.info.maxTemperature.toDegrees()
                        } else {
                            item.info.feelsLike.toFahrenheit()
                            item.info.temperature.toFahrenheit()
                            item.info.minTemperature.toFahrenheit()
                            item.info.maxTemperature.toFahrenheit()
                        }
                    }
                    self.forecast = buffer
                }
            }
        }
        
        init(container: DependencyInjector, weatherService: WeatherService, dateService: DateService) {
            self.container = container
            self.weatherService = weatherService
            self.dateService = dateService
            cancelBag = CancelBag()
            
            let reachability = try! Reachability()
            reachability.whenReachable = { reachability in
                self.setSubscription()
            }
            reachability.whenUnreachable = { _ in
                self.error.0 = CurrentWeatherView.Errors.noInternetConnection
                self.error.1 = true
            }

            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
            
            setSubscription()
        }
        
        func currentDate() -> String {
            dateService.getCurrentDate()
        }
        
        func convert(to units: AppEnvironment.WeatherUnits) {
            print(self.forecast)
            $forecast
                .eraseToAnyPublisher()
                .map {
                    var buffer = $0
                    buffer.weather.changeEach { item in
                        if units == .degrees {
                            item.info.feelsLike.toDegrees()
                            item.info.temperature.toDegrees()
                            item.info.minTemperature.toDegrees()
                            item.info.maxTemperature.toDegrees()
                        } else {
                            item.info.feelsLike.toFahrenheit()
                            item.info.temperature.toFahrenheit()
                            item.info.minTemperature.toFahrenheit()
                            item.info.maxTemperature.toFahrenheit()
                        }
                    }
                    return buffer
                }
                .assign(to: \.forecast, on: self)
                .store(in: cancelBag)
        }
        
        func showForecast() {
            weatherService
                .getDailyWeather()
                .map { $0 as Forecast }
                .catch { error -> Just<Forecast> in
                    if error is WeatherService.Errors {
                        return Just(Forecast.empty)
                    } else {
                        self.error.0 = error
                        self.error.1 = true
                        return Just(Forecast.empty)
                    }
                }
                .eraseToAnyPublisher()
                .sink(receiveCompletion: {
                    switch $0 {
                    case .finished:
                        self.setCurrentWeatherPublisher()
                        self.setHourlySelectionPublisher()
                        self.setDailyWeatherPublisher()
                        self.setCityPublisher()
                    case .failure(let error):
                        self.error.0 = error
                        self.error.1 = true
                    }
                } , receiveValue: {
                    self.container.appState[\.system.units] = AppEnvironment.WeatherUnits.degrees
                    self.forecast = $0
                })
                .store(in: cancelBag)
        }
        
        func showForecast(by city: String) {
            weatherService
                .getDailyWeather(by: city)
                .map { $0 as Forecast }
                .catch { error -> Just<Forecast> in
                    if error is WeatherService.Errors {
                        return Just(Forecast.empty)
                    } else {
                        self.error.0 = error
                        self.error.1 = true
                        return Just(Forecast.empty)
                    }
                }
                .eraseToAnyPublisher()
                .sink(receiveCompletion: {
                    switch $0 {
                    case .finished:
                        self.setCurrentWeatherPublisher()
                        self.setHourlySelectionPublisher()
                        self.setDailyWeatherPublisher()
                        self.setCityPublisher()
                    case .failure(let error):
                        self.error.0 = error
                        self.error.1 = true
                    }
                } , receiveValue: {
                    self.container.appState[\.system.units] = AppEnvironment.WeatherUnits.degrees
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
        
        func setForecastPublisher() {
            $updateForecast
                .eraseToAnyPublisher()
                .sink {
                    print($0)
                } receiveValue: { [weak self] in
                    guard let self = self else { return }
                    self.showForecast(by: self.city.name)
                }
                .store(in: cancelBag)
        }
        
        func setSubscription() {
            self.setCurrentWeatherPublisher()
            self.setHourlySelectionPublisher()
            self.setDailyWeatherPublisher()
            self.setCityPublisher()
        }
    }
}

extension CurrentWeatherView {
    enum Errors: Error, LocalizedError {
        case noInternetConnection
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return L10n.network
            }
        }
    }
}
