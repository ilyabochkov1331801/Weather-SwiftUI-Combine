//
//  Optional + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import UIKit

extension Optional where Wrapped == UIFont {
    var unwrapped: UIFont {
        guard let unwrapped = self else {
            return UIFont()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == String {
    var unwrapped: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}
