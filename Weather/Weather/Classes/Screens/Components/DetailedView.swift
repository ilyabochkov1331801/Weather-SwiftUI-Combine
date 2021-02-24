//
//  SwiftUIView.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

struct DetailedView: View {
    @Binding var value: String
    
    var parameter:  String
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 55.widthDependent(), height: 55.heightDependent(), alignment: .center)
            VStack(alignment: .center, spacing: 10) {
                Text(value)
                    .customFont(name: FontFamily.Roboto.regular.name, size: 15)
                    .foregroundColor(.white)
                Text(parameter)
                    .customFont(name: FontFamily.Roboto.regular.name, size: 10)
                    .foregroundColor(Color(Asset.midGray.name))
                    .minimumScaleFactor(0.4)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(value: .constant("30%"), parameter: "Humidity")
    }
}
