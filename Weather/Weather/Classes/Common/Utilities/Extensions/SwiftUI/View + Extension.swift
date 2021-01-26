//
//  View + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

// MARK: - Gradient
extension View {
    public func gradientForeground(colors: [Color], points: [UnitPoint]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: points[0],
                                    endPoint: points[1]))
            .mask(self)
    }
}

// MARK: - Font
extension View {
    func customFont(
        name: String,
        size: CGFloat,
        weight: SwiftUI.Font.Weight = .regular) -> some View {
        return self.modifier(CustomFont(name: name, size: size, weight: weight))
    }
}
