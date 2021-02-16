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
    
    public var body: some View {
        ZStack{
            Text("\(self.currentNumber, specifier: "%.2f")")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y: -110.heightDependent())
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black)
                .frame(width: 60, height: 270.heightDependent())
                .shadow(color: Color(Asset.trout.name), radius: 12, x: 0, y: 6 )
                .foregroundColor(.clear)
                .blur(radius: 3.0)
                .blendMode(.multiply)
            Text("\(self.currentString)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y: 110.heightDependent())
                .foregroundColor(.white)
        }
    }
}
