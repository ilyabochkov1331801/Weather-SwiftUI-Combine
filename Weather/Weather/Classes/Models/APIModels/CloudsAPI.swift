//
//  CloudsAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Foundation

struct CloudsAPI: Codable {
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "all"
    }
}
