//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dependencyInjector) var dep: DependencyInjector
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
