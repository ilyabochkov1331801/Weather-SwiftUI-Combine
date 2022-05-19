//
//  Array + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 15.02.21.
//

import Foundation

extension Array {
    mutating func changeEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { item in
            var element = item
            try transform(&element)
            return element
        }
    }
}
