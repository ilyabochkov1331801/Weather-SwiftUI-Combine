//
//  TestView.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.01.21.
//

import SwiftUI

struct TestView: View {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    var body: some View {
        Button {
            router.dismiss()
        } label: {
            Text("Back")
                .padding()
        }
    }
}
