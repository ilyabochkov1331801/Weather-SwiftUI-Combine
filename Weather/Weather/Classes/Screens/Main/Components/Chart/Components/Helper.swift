//
//  Helper.swift
//  Weather
//
//  Created by Alena Nesterkina on 26.01.21.
//

import Foundation
import SwiftUI

struct GradientColor {
    let start: Color
    let end: Color
    
    init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

class ChartStyle {
    var backgroundColor: Color
    var accentColor: Color
    var gradientColor: GradientColor
    var textColor: Color
    var legendTextColor: Color
    var dropShadowColor: Color
    
    init(backgroundColor: Color, accentColor: Color, gradientColor: GradientColor, textColor: Color, legendTextColor: Color, dropShadowColor: Color) {
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = gradientColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
}

class ChartData: ObservableObject, Identifiable {
    @Published var points: Binding<[(String, Double)]>
    var valuesGiven: Bool = false
    var ID = UUID()
    
    init(values: Binding<[(String,Double)]> ){
        self.points = values
        self.valuesGiven = true
    }
    
    func onlyPoints() -> [Double] {
        return self.points.wrappedValue.map{ $0.1 }
    }
    
    func onlyStrings() -> [String] {
        return self.points.wrappedValue.map{ $0.0 }
    }
}
