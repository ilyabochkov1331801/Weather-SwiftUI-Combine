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
        ZStack {
            Text("\(self.currentNumber, specifier: "%.0f")")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y: -90.heightDependent())
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 60, height: 250.heightDependent())
                .foregroundColor(.white)
                .shadow(color: Color(Asset.trout.name), radius: 12, x: 0, y: 6 )
                .blendMode(.multiply)
            Text("\(self.currentString)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y: 90.heightDependent())
                .foregroundColor(.white)
        }
    }
}
