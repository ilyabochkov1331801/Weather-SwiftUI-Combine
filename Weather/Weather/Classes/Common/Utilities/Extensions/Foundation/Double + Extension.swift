//
//  Double + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 15.02.21.
//

import Foundation

extension Double {
    mutating func toFarengheit() {
        self = (self * 9 / 5) + 32
    }
    
    mutating func toDegrees() {
        self = (self - 32) * 5 / 9
    }
}
