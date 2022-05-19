//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.02.21.
//

import SwiftUI

extension SettingsView {
    class ViewModel: ObservableObject {
        @Published var currencyUnits: Int
        
        let container: DependencyInjector
        private var cancelBag = CancelBag()
        
        init(container: DependencyInjector) {
            cancelBag = CancelBag()
            self.container = container
            let appState = container.appState
            
            _currencyUnits = .init(initialValue: appState.value.system.units.index ?? 0)
            $currencyUnits
                .sink {
                    appState[\.system.units] = AppEnvironment.WeatherUnits.allCases[$0]
                    print(appState.value.system.units.rawValue)
                }
                .store(in: cancelBag)
        }
    }
}
