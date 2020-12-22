//
//  Weather.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

typealias Deegrees = Double

struct Weather {
    
    enum State: String {
        case unexpected

        case rain = "Rain"
    }
    
    let temperature: Deegrees
    let state: State
    let date: Date
}

extension Weather: AppConvertableTarget { }
