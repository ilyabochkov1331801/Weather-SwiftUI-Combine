//
//  WindAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct WindAPI: Codable {
    let speed: Double
    let deg: Int
}
