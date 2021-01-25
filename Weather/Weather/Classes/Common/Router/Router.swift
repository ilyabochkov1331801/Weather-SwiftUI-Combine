//
//  Router.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

class Router: ObservableObject {
    struct State {
        var navigating: AnyView? = nil
        var sheetPresenting: AnyView? = nil
        var isPresented: Binding<Bool>
    }
    
    @Published private(set) var state: State
    
    init(isPresented: Binding<Bool>) {
        state = State(isPresented: isPresented)
    }
}

extension Router {
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0}
        )
    }
    
    func boolBinding<T>(keyPath: WritableKeyPath<State, T?>) -> Binding<Bool> {
        Binding(
            get: { self.state[keyPath: keyPath] != nil },
            set: {
                if !$0 {
                    self.state[keyPath: keyPath] = nil
                }
            }
        )
    }
}

extension Router {
    func navigateTo<V: View>(_ view: V) {
        state.navigating = AnyView(view)
    }
    
    func presentSheet<V: View>(_ view: V) {
        state.sheetPresenting = AnyView(view)
    }
    
    func dismiss() {
        state.isPresented.wrappedValue = false
    }
}

extension Router {
    var isNavigating: Binding<Bool> {
        boolBinding(keyPath: \.navigating)
    }
    
    var isSheetPresenting: Binding<Bool> {
        boolBinding(keyPath: \.sheetPresenting)
    }
    
    var isPresented: Binding<Bool> {
        state.isPresented
    }
}
