//
//  MagnifierRect.swift
//  Weather
//
//  Created by Alena Nesterkina on 26.01.21.
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    @Binding var currentString: String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    public var body: some View {
        ZStack{
            Text("\(self.currentNumber, specifier: "%.0f")")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y:-110)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 60, height: 280)
                    .foregroundColor(Color.white)
                .shadow(color: Color(Asset.trout.name), radius: 12, x: 0, y: 6 )
                    .blendMode(.multiply)
            Text("\(self.currentString)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y:110)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
        }
    }
}
