//
//  ContentViewRouter.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

class CurrentWeatherViewRouter: Router, CurrentWeatherViewRouterProtocol {
    func presentSettings<V>(view: V) where V : View {
        presentSheet (
           view
        )
    }
    
    func presentNext(weather: Binding<[Weather]>) {
        presentSheet(
            DailyWeatherView(weather: weather)
        )
    }
}
