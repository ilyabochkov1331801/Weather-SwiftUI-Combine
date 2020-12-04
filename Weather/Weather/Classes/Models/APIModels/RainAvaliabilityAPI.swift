//
//  RainAvaliabilityAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct RainAvaliabilityAPI: Codable {
    let expectation: Double
    
    enum CodingKeys: String, CodingKey {
        case expectation = "3h"
    }
}
