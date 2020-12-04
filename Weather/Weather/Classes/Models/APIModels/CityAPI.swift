//
//  CityAPI.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine
import Foundation

struct CityAPI: Codable {
    let id: String
    let coordinates: CoordinatesAPI
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case coordinates = "coord"
        case country
        case timezone
        case sunrise
        case sunset
    }
}

extension CityAPI: AppConvertable {
    typealias Target = City
    
    func convert() -> AnyPublisher<Target, Never> {
        Just(
            Target(name: country,
                   sunrise: Date(timeIntervalSince1970: Double(sunrise)),
                   sunset: Date(timeIntervalSince1970: Double(sunset)))
        )
        .eraseToAnyPublisher()
    }
}
