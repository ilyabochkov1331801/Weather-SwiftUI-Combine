//
//  CustomFont.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import Foundation
import SwiftUI

struct CustomFont: ViewModifier {
    var name: String
    var size: CGFloat
    var weight: SwiftUI.Font.Weight = .regular

    func body(content: Content) -> some View {
        return content.font(SwiftUI.Font.custom(
            name,
            size: size)
            .weight(weight))
    }
}
