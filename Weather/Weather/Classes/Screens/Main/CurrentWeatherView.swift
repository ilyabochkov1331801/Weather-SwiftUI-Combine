//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import Combine
import SwiftUI

protocol CurrentWeatherViewRouterProtocol: Router {
    func presentSettings<V: View>(view: V)
    func presentNext(weather: Binding<[Weather]>)
}

struct CurrentWeatherView<Router: CurrentWeatherViewRouterProtocol>: View {
    @StateObject var viewModel: ViewModel
    @StateObject private var router: Router
    
    init(router: Router, viewModel: ViewModel) {
        _router = StateObject(wrappedValue: router)
        _viewModel = StateObject(wrappedValue: viewModel)
        setupUI()
        viewModel.showForecast()
    }
    @State var trim: CGFloat = 0
    
    var menuButton: some View {
        Button(action: {
            let settingsView = SettingsView(viewModel: .init(container: viewModel.container),
                                            city: $viewModel.city.name,
                                            updateForecast: $viewModel.updateForecast,
                                            onChange: viewModel.onChangeHandler)
                .inject(viewModel.container)
            router.presentSettings(view: settingsView)
            
        }) {
            Image(Asset.menu.name)
                .resizable()
        }
        .sheet(router)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20) {
                    CardPreview(city: $viewModel.city, currentWeather: $viewModel.currentWeather)
                        .padding(.horizontal)
                    
                    LineView(data: $viewModel.hourlyWeather, title: "Today", legend: "Weather each 3 hours",
                             style: ChartStyle(backgroundColor: .clear,
                                               accentColor: Color(Asset.manatee.name),
                                               gradientColor: GradientColor(start: Color(Asset.malibu.name),
                                                                            end: Color(Asset.electricViolet.name)),
                                               textColor: .white,
                                               legendTextColor: Color(Asset.manatee.name),
                                               dropShadowColor: .clear))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 200, alignment: .center)
                    
                    HStack(alignment: .center) {
                        BottomButton {
                            router.presentNext(weather: $viewModel.dailyWeather)
                        }
                        .offset(y: UIScreen.main.bounds.height / 5)
                        .sheet(router)
                        
                        Button(action: {
                            viewModel.showForecast()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.white)
                        })
                        .offset(y: UIScreen.main.bounds.height / 5 )
                    }
                }.offset(y: 80)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Today \(viewModel.currentDate())", displayMode: .inline)
            .navigationBarItems(trailing: menuButton)
        }
        .alert(isPresented: $viewModel.error.1, content: {
            Alert(title: Text("Attention!!!"), message: Text(viewModel.error.0.localizedDescription), dismissButton: .default(Text("Cancel")))
        })
        
    }
    
    func setupUI() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(font: FontFamily.Roboto.regular, size: 20.0).unwrapped]
    }
}
