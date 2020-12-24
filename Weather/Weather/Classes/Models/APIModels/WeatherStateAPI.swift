//
//  WeatherStateAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct WeatherStateAPI: Codable {
    let id: Int
    let state: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case state = "main"
        case description
        case icon
    }
}
