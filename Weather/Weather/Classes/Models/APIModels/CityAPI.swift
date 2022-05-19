//
//  CityAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct CityAPI: Codable {
    let id: Int
    let coordinates: CoordinatesAPI
    let name: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case coordinates = "coord"
        case name
        case timezone
        case sunrise
        case sunset
    }
}

extension CityAPI: AppConvertable {
    typealias Target = City
    
    func convert() -> AnyPublisher<Target, Never> {
        Just(
            Target(name: name,
                   sunrise: Date(timeIntervalSince1970: Double(sunrise)),
                   sunset: Date(timeIntervalSince1970: Double(sunset)))
        )
        .eraseToAnyPublisher()
    }
}
