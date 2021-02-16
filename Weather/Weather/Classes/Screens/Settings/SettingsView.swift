//
//  SettingsView.swift
//  Weather
//
//  Created by Alena Nesterkina on 10.02.21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var city: String
    @Binding var updateForecast: Void
    @State private var currencyUnits: String = AppState.System.units.rawValue
    var units: [String] = ["Celsius(°C)", "Fahrenheit(°F)"]
    
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
                        Picker(selection: $currencyUnits, label: Text("Temperature units")
                                .lineLimit(.zero)
                                .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                        ) {
                            Text("Celsius(°C)").tag(0)
                            Text("Fahrenheit(°F)").tag(1)
                        }
                        .onChange(of: currencyUnits) { _ in
                            guard let index = (units.firstIndex { $0 == currencyUnits }) else {
                                return
                            }
                            AppState.System.units = AppEnvironment.WeatherUnits.allCases[index]
                        }
                        RegionView(text: $city, updateForecast: $updateForecast)
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
