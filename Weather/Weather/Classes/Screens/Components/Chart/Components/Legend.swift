//
//  Legend.swift
//  Weather
//
//  Created by Alena Nesterkina on 26.01.21.
//

import SwiftUI

struct Legend: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    let padding: CGFloat = 3
    
    var stepWidth: CGFloat {
        if data.points.wrappedValue.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.wrappedValue.count - 1)
    }
    var stepHeight: CGFloat {
        let points = self.data.onlyPoints()
        if let min = points.min(), let max = points.max(), min != max {
            if min < 0 {
                return (frame.size.height-padding) / CGFloat(max - min)
            } else {
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        let points = self.data.onlyPoints()
        return CGFloat(points.min() ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach((0...9), id: \.self) { height in
                HStack(alignment: .center) {
                    Text("\(self.getYLegendSafe(height: height), specifier: "%.2f")").offset(x: 0, y: self.getYposition(height: height) )
                        .foregroundColor(Color(Asset.mischka.name))
                        .font(.caption)
                    self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
                        .stroke(Color(Asset.mountainMist.name), style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5, 10]))
                        .opacity(hideHorizontalLines ? 0 : 0.3)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
                
            }
            
        }
    }
    
    func getYLegendSafe(height:Int) -> CGFloat {
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    func getYposition(height: Int) -> CGFloat {
        if let legend = getYLegend() {
            return (self.frame.height - ((CGFloat(legend[height]) - min) * self.stepHeight)) - (self.frame.height / 2)
        }
        return 0
        
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x: 5, y: (atHeight - min) * stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight - min) * stepHeight))
        return hLine
    }
    
    func getYLegend() -> [Double]? {
        let points = self.data.onlyPoints()
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let step = Double(max - min) / Double(points.count)
        var result: [Double] = []
        for index in 0...points.count {
            result.append(min + step * Double(index))
        }
        return result
    }
}
