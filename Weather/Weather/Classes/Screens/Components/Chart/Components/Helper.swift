//
//  Helper.swift
//  Weather
//
//  Created by Alena Nesterkina on 26.01.21.
//

import Foundation
import SwiftUI

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

public class ChartStyle {
    public var backgroundColor: Color
    public var accentColor: Color
    public var gradientColor: GradientColor
    public var textColor: Color
    public var legendTextColor: Color
    public var dropShadowColor: Color
    
    public init(backgroundColor: Color, accentColor: Color, gradientColor: GradientColor, textColor: Color, legendTextColor: Color, dropShadowColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = gradientColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
}

public class ChartData: ObservableObject, Identifiable {
    @Published var points: [(String,Double)]
    var valuesGiven: Bool = false
    var ID = UUID()
    
    public init<N: BinaryFloatingPoint>(points:[N]) {
        self.points = points.map{("", Double($0))}
    }
    public init<N: BinaryInteger>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryInteger>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    
    public func onlyPoints() -> [Double] {
        return self.points.map{ $0.1 }
    }
    
    public func onlyStrings() -> [String] {
        return self.points.map{ $0.0 }
    }
}
