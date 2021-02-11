//
//  ContentViewRouter.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

class ContentViewRouter: Router, ContentRouterProtocol {
    func presentTest() {
        let router = Router(isPresented: isNavigating)
        navigateTo (
            TestView(router: router)
        )
    }
    
    func presentSettings() {
        let router = Router(isPresented: isNavigating)
        presentSheet (
            SettingsView()
        )
    }
}
