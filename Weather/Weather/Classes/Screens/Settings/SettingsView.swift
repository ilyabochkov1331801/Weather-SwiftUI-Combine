//
//  SettingsView.swift
//  Weather
//
//  Created by Alena Nesterkina on 10.02.21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: ViewModel
    @Binding var city: String
    @Binding var updateForecast: Void
    
    let onChange: (() -> Void)?
    private var units: [String] = ["Celsius(°C)", "Fahrenheit(°F)"]
    
    init(viewModel: ViewModel, city: Binding<String>, updateForecast: Binding<Void>, onChange: @escaping (() -> Void)) {
        _city = city
        _updateForecast = updateForecast
        self.viewModel = viewModel
        self.onChange = onChange
        setupUI()
    }
    
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
                        Picker(selection: $viewModel.currencyUnits, label: Text("Temperature units")
                                .lineLimit(.zero)
                                .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                        ) {
                            ForEach(0..<units.count) {
                                Text(self.units[$0]).tag($0)
                            }.preferredColorScheme(.light)
                        }
                        .listRowBackground(Color.white)
                        .onChange(of: viewModel.currencyUnits) { _ in
                            guard let closure = onChange else {
                                return
                            }
                            closure()
                        }
                        RegionView(text: $city, updateForecast: $updateForecast)
                    }.listRowBackground(Color.white)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    func setupUI() {
        UITableView.appearance().backgroundColor = Asset.charade.color
        
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().backgroundColor = Asset.charade.color
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(font: FontFamily.Roboto.bold, size: 20.0).unwrapped]
    }
}
