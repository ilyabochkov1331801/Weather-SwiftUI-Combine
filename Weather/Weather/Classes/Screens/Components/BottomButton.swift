//
//  BottomButton.swift
//  Weather
//
//  Created by Alena Nesterkina on 28.01.21.
//

import SwiftUI

struct BottomButton: View {
    
    var navigationClosure: () -> ()
    
    var body: some View {
        ZStack(alignment: .center) {
            Button(action: {
                navigationClosure()
            }) {
                Text("Next 5 days")
                    .customFont(name: FontFamily.Roboto.regular.name, size: 15)
                    .foregroundColor(.white)
            }
            .frame(width: 200, height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [Color(Asset.trout.name), Color(Asset.brightGray.name)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
