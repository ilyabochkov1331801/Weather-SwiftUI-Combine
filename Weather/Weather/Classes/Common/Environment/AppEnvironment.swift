//
//  AppEnvironment.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine

struct AppEnvironment {
    let container: DependencyInjector
    
    enum WeatherUnits: String, CaseIterable {
        case degrees = "Celsius(°C)"
        case fahrenheit = "Fahrenheit(°F)"
        
        static func fromString(string: String) -> WeatherUnits {
            for type in WeatherUnits.allCases {
                if type.rawValue == string {
                    return type
                }
            }
            return .degrees
        }
    }
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        AppEnvironment(container: .defaultValue)
    }
}
