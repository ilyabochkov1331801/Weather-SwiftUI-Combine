//
//  CardPreview.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

struct CardPreview: View {
    @Binding var city: City
    @Binding var currentWeather: Weather
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(Asset.trout.name), Color(Asset.brightGray.name)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 340.widthDependent(), height: 150.heightDependent(), alignment: .center)
            VStack(alignment: .leading) {
                HStack(spacing: 100) {
                    HStack {
                        Image(currentWeather.iconName)
                            .resizable()
                            .frame(width: 40, height: 36)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(currentWeather.state.description)
                                .lineLimit(.zero)
                                .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                                .foregroundColor(.white)
                            Text(city.name)
                                .customFont(name: FontFamily.Roboto.regular.name, size: 14)
                                .foregroundColor(Color(Asset.midGray.name))
                        }
                        Spacer()
                        Text(String(currentWeather.info.temperature.rounded()))
                            .customFont(name: FontFamily.Roboto.regular.name, size: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    
                        
                }.padding(.bottom, 15)
                
                HStack(spacing: 20) {
                    DetailedView(value: .constant(String(currentWeather.info.feelsLike)), parameter: "Sensibility")
                    DetailedView(value: .constant(String(currentWeather.info.humidity)), parameter: "Humidity")
                    DetailedView(value: .constant(String(currentWeather.wind)), parameter: "W Force")
                    DetailedView(value: .constant("\(currentWeather.info.pressure) pHa"), parameter: "Pressure")
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}
