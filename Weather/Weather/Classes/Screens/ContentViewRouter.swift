//
//  ContentViewRouter.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

class ContentViewRouter: Router, ContentRouterProtocol {
    func presentSettings<V>(view: V) where V : View {
        presentSheet (
           view
        )
    }
    
    func presentNext(weather: Binding<[Weather]>) {
        presentSheet(
            NextDaysView(weather: weather)
        )
    }
}
