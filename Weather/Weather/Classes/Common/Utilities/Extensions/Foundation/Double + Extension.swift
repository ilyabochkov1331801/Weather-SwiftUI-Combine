//
//  Double + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 15.02.21.
//

import Foundation

extension Double {
    mutating func toFahrenheit() {
        self = ((self * 9 / 5) + 32).rounded()
    }
    
    mutating func toDegrees() {
        self = ((self - 32) * 5 / 9).rounded()
    }
}
