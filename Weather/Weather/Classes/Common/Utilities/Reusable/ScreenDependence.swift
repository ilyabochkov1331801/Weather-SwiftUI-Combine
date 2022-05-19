//
//  ScreenDependence.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import Foundation
import UIKit

protocol ScreenDependent {
    /// Device's screen width dependent value
    func widthDependent(layoutWidth: CGFloat) -> CGFloat

    /// Device's screen height dependent value
    func heightDependent(layoutHeight: CGFloat) -> CGFloat

    /// Device's screen font size height dependent value
    func fontSizeDependent(layoutHeight: CGFloat) -> CGFloat
}

extension ScreenDependent where Self: Numeric {
    /// Device's screen width dependent value
    func widthDependent(layoutWidth: CGFloat = 375) -> CGFloat {
        cgFloat.dependent(multiplier: widthMultiplier(layoutWidth: layoutWidth))
    }

    /// Device's screen height dependent value
    func heightDependent(layoutHeight: CGFloat = 812) -> CGFloat {
        cgFloat.dependent(multiplier: heightMultiplier(layoutHeight: layoutHeight))
    }

    /// Device's screen font size height dependent value
    func fontSizeDependent(layoutHeight: CGFloat = 812) -> CGFloat {
        cgFloat.dependent(multiplier: heightMultiplier(layoutHeight: layoutHeight))
    }
}

extension Float: ScreenDependent { }
extension Double: ScreenDependent { }
extension Int: ScreenDependent { }
extension CGFloat: ScreenDependent { }
extension UInt: ScreenDependent { }

extension Numeric {
    var cgFloat: CGFloat {
        let offset: CGFloat
        if let amount = self as? Float {
            offset = CGFloat(amount)
        } else if let amount = self as? Double {
            offset = CGFloat(amount)
        } else if let amount = self as? CGFloat {
            offset = CGFloat(amount)
        } else if let amount = self as? Int {
            offset = CGFloat(amount)
        } else if let amount = self as? UInt {
            offset = CGFloat(amount)
        } else {
            offset = 0.0
        }
        return offset
    }

    func widthMultiplier(layoutWidth: CGFloat) -> CGFloat {
        UIScreen.main.bounds.width / layoutWidth
    }

    func heightMultiplier(layoutHeight: CGFloat) -> CGFloat {
        UIScreen.main.bounds.height / layoutHeight
    }

    func fontSizeMultiplier(layoutHeight: CGFloat) -> CGFloat {
        let heightMultiplier = self.heightMultiplier(layoutHeight: layoutHeight)
        return heightMultiplier >= 1 ? heightMultiplier : heightMultiplier * 1.2
    }
}
