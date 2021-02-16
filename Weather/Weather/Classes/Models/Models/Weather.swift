//
//  Weather.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import UIKit

typealias Deegrees = Double

struct Weather {
    typealias State = (description: String, icon: String)
    let state: State
    let date: Date
    var info: WeatherInfo
    let wind: Double
    
    static let empty: Weather = Weather(state: ("No info", "No info"),
                                        date: Date(),
                                        info: WeatherInfo.empty,
                                        wind: 0)
}

extension Weather: AppConvertableTarget { }

extension Weather {
    var iconName: String {
        if state.description == "No info" {
            return "clearD"
        }
        return state.description.lowercased() + String(state.icon.last ?? "d").uppercased()
    }
}
