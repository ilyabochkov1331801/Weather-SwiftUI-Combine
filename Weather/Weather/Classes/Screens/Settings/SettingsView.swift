//
//  SettingsView.swift
//  Weather
//
//  Created by Alena Nesterkina on 10.02.21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var currencyCode = "Celsius(°C)"
    var codes: [String] = ["Celsius(°C)", "Fahrenheit(°F)"]
    
    var closeButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(Asset.cancel.name)
                .resizable()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                Form {
                    Section {
                        Picker(selection: $currencyCode, label: Text("Temperature units")
                                .lineLimit(.zero)
                               .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                        ) {
                            ForEach(codes, id: \.self) { (string: String) in
                                Text(string)
                            }
                        }
                        RegionView()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    func setupUI() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = Asset.charade.color
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(font: FontFamily.Roboto.bold, size: 20.0).unwrapped]
    }
}
