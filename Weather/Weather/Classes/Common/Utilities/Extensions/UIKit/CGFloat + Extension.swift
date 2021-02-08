//
//  CGFloat + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import Foundation
import UIKit

extension CGFloat {
    func precisedTo(digits power: Int) -> CGFloat {
        let delimiter = 10 ^^ power
        return (self * CGFloat(delimiter)).rounded(.toNearestOrEven) / CGFloat(delimiter)
    }

    func dependent(multiplier: CGFloat, precision: Int = 2) -> CGFloat {
        (self * multiplier).precisedTo(digits: precision)
    }
}

infix operator ^^
private func ^^ (radix: Int, power: Int) -> CGFloat {
    CGFloat(pow(Double(radix), Double(power)))
}
