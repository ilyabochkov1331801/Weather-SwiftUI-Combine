//
//  CaseIterable + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 16.02.21.
//

import Foundation

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
