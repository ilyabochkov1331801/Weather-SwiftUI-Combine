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
