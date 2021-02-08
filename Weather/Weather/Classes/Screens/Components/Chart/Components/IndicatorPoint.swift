//
//  IndicatorPoint.swift
//  Weather
//
//  Created by Alena Nesterkina on 26.01.21.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(Asset.hotPink.name))
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
        .shadow(color: Color(Asset.midGray.name), radius: 6, x: 0, y: 6)
    }
}
