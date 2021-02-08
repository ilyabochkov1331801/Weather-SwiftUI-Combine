//
//  CardPreview.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

struct CardPreview: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(Asset.trout.name), Color(Asset.brightGray.name)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 340.widthDependent(), height: 150.heightDependent(), alignment: .center)
            VStack(alignment: .leading) {
                HStack(spacing: 100) {
                    HStack {
                        Image(Asset.cloudy.name)
                            .resizable()
                            .frame(width: 40, height: 36)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Cloudy")
                                .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                                .foregroundColor(.white)
                            Text("Minsk, Belarus")
                                .customFont(name: FontFamily.Roboto.regular.name, size: 10)
                                .foregroundColor(Color(Asset.midGray.name))
                        }
                    }
                    Text("28*")
                        .customFont(name: FontFamily.Roboto.regular.name, size: 30)
                        .foregroundColor(.white)
                        
                }.padding(.bottom, 15)
                
                HStack(spacing: 20) {
                    DetailedView(value: .constant("31*C"), parameter: "Sensible")
                    DetailedView(value: .constant("65%"), parameter: "Humidity")
                    DetailedView(value: .constant("3"), parameter: "W Force")
                    DetailedView(value: .constant("1000 pHa"), parameter: "Pressure")
                }
                
            }
        }
    }
}

struct CardPreview_Previews: PreviewProvider {
    static var previews: some View {
        CardPreview()
    }
}
