//
//  NextDaysView.swift
//  Weather
//
//  Created by Alena Nesterkina on 10.02.21.
//

import SwiftUI

struct NextDaysView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var weather: [Weather]
    
    init(weather: Binding<[Weather]>) {
        _weather = weather
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
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(weather, id: \.self) { state in
                            CellView(image: "cloudy", weather: state)
                        }
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Next 5 days weather", displayMode: .inline)
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
