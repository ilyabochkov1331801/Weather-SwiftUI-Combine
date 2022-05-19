//
//  View + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

extension View {
    func navigation(_ router: Router) -> some View {
        self.modifier(NavigationModifier(presentingView: router.binding(keyPath: \.navigating)))
    }
    
    func sheet(_ router: Router) -> some View {
        self.modifier(SheetModifier(presentingView: router.binding(keyPath: \.sheetPresenting)))
    }
}
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

extension View {
    func inject(_ container: DependencyInjector) -> some View {
        return self
            .environment(\.dependencyInjector, container)
    }
}
