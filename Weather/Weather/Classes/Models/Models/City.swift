//
//  City.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct City {
    let name: String
    let sunrise: Date
    let sunset: Date
}

extension City: AppConvertableTarget { }
