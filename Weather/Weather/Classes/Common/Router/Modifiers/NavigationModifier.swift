//
//  NavigationModifier.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    @Binding var presentingView: AnyView?
    
    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(destination: self.presentingView,
                               isActive: Binding(
                                get: { self.presentingView != nil },
                                set: { if !$0 {
                                    self.presentingView = nil
                                }})
                ) {
                    EmptyView()
                }
            )
    }
}
