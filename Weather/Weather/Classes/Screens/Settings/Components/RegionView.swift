//
//  RegionView.swift
//  Weather
//
//  Created by Alena Nesterkina on 11.02.21.
//

import SwiftUI

struct RegionView: View {
    @State var toggle = false
    @State var text: String = ""
    @State var trim: CGFloat = 1
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField("Type city name...", text: $text, onCommit: {
                withAnimation {
                    self.toggle.toggle()
                    self.trim = self.toggle ? 0 : 1
                }
            })
            .foregroundColor(.white)
            .background(Color.clear)
            AnimatedCellView(trim: $trim)
            CellContentView(grow: $toggle, text: $text) {
                withAnimation {
                    self.toggle.toggle()
                    self.trim = self.toggle ? 0 : 1
                }
            }
            
        }
        
    }
}

struct CellContentView: View {
    @Binding var grow: Bool
    @Binding var text: String
    
    var animationCallback: () -> Void
    
    var body: some View {
        Button(action: {
            animationCallback()
        }, label: {
            HStack {
                Text("Change region")
                    .customFont(name: FontFamily.Roboto.regular.name, size: 18)
                    .foregroundColor(.white)
                Spacer()
                Text(text)
                    .customFont(name: FontFamily.Roboto.regular.name, size: 14)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 30)
        })
        .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
        .opacity(grow ? 0 : 1)
    }
}

struct AnimatedCellView: View {
    @State var grow: Bool = false
    @Binding var trim: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                Rectangle()
                    .frame(
                        minWidth: 0,
                        maxWidth: self.grow
                            ? geo.frame(in: .global).width * self.trim
                            : 0)
                    .foregroundColor(Color(Asset.shark.name))
                    .animation(Animation.easeOut(duration: 1.2).delay(0.3))
            }
        }
        .onAppear(perform: {
            self.grow = true
        })
    }
}
