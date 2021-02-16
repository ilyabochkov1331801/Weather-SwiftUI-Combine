//
//  City.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct City {
    var name: String
    let sunrise: Date
    let sunset: Date
    
    static let empty = City(name: "No name", sunrise: Date(), sunset: Date())
}

extension City: AppConvertableTarget { }
