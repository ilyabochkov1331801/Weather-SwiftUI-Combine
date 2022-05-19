//
//  DataManagers.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine

extension DependencyInjector {
    class Providers {
        let locationProvider: LocationProvider
        let apiProvider: APIProvider
        
        init(locationProvider: LocationProvider, apiProvider: APIProvider) {
            self.locationProvider = locationProvider
            self.apiProvider = apiProvider
        }
        
        static var stub: Providers {
            Providers(locationProvider: LocationProvider(), apiProvider: APIProvider())
        }
    }
}
