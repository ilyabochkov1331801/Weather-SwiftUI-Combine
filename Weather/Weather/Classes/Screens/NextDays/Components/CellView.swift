//
//  CellView.swift
//  Weather
//
//  Created by Alena Nesterkina on 10.02.21.
//

import SwiftUI

struct CellView: View {
    @State var image: String
    @State var weather: Weather
    
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack(alignment: .center) {
                Circle()
                    .fill(Color(Asset.brightGray.color))
                    .frame(width: 70, height: 70)
                Image(Asset.rain.name)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(Color.clear)
            }.background(Color.clear)
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(Asset.brightGray.color))
                    .frame(width: UIScreen.main.bounds.width.widthDependent() * 0.6, height: 70)
                HStack(spacing: 30) {
                    Text(String(format: "%.0f°", weather.info.temperature))
                        .lineLimit(.zero)
                        .customFont(name: FontFamily.Roboto.regular.name, size: 30)
                        .foregroundColor(.white)
                    VStack(spacing: 5) {
                        Text(weather.date.dayNameOfWeek() ?? "")
                            .lineLimit(.zero)
                            .customFont(name: FontFamily.Roboto.regular.name, size: 20)
                            .foregroundColor(Color(Asset.mountainMist.name))
                        Text(weather.date.monthAndDay() ?? "")
                            .lineLimit(.zero)
                            .customFont(name: FontFamily.Roboto.regular.name, size: 13)
                            .foregroundColor(Color(Asset.manatee.name))
                    }
                }
                .frame(width: UIScreen.main.bounds.width.widthDependent() * 0.6, height: 70)
            }
        }
    }
}


struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(image: Asset.cloudy.name,
                 weather: Weather(state: "Cloudy",
                                  date: Date(),
                                  info: WeatherInfo(temperature: 6.0,
                                                    feelsLike: 6.0,
                                                    minTemperature: 6.0,
                                                    maxTemperature: 6.0,
                                                    pressure: 6,
                                                    humidity: 6),
                                  wind: 6))
    }
}
