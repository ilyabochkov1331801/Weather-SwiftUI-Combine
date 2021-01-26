//
//  ContentView.swift
//  Weather
//
//  Created by Alena Nesterkina on 3.12.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dependencyInjector) private var dependencyInjector: DependencyInjector
    @StateObject var viewModel: ViewModel
    @State var trim: CGFloat = 0
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        setupUI()
    }
    
    var menuButton: some View {
        Button(action: {
        }) {
            Image(Asset.menu.name)
                .resizable()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Asset.charade.name)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    CardPreview()
                        .padding()
                    LineView(data: [("00:00", -8.0),("03:00", 23.0),("06:00", 54.0),("09:00", 32.0),("12:00", 12.0),("15:00", 37.0),("18:00", -7.0),("21:00", 37.0),("24:00", 17.0)], title: "Today", legend: "Weather each 3 hours",
                             style: ChartStyle(backgroundColor: .clear, accentColor: Color(Asset.manatee.name), gradientColor: GradientColor(start: Color(Asset.malibu.name), end: Color(Asset.electricViolet.name)), textColor: .white, legendTextColor: Color(Asset.manatee.name), dropShadowColor: .clear))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 200, alignment: .center)
                }
                .offset(y: 100)
                
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Today \(viewModel.getCurrentDate())", displayMode: .inline)
            .navigationBarItems(trailing: menuButton)
        }
    }
    
    func setupUI() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Asset.midGray.color, .font: UIFont(font: FontFamily.Roboto.regular, size: 20.0).unwrapped]
    }
    
    class ViewModel: ObservableObject {
        private let weatherService: WeatherService
        private let dateService: DateService
        private let cancelBag: CancelBag
    
        @Published var weather: Weather?
        
        init(weatherService: WeatherService, dateService: DateService) {
            self.weatherService = weatherService
            self.dateService = dateService
            cancelBag = CancelBag()
        }
        
        func getCurrentDate() -> String {
            dateService.getCurrentDate()
        }
        
        func showForecast() {
            weatherService
                .getDailyWeather()
                .map { $0.weather.first }
                .eraseToAnyPublisher()
                .replaceError(with: nil)
                .assign(to: \.weather, on: self)
                .store(in: cancelBag)
        }
    }
}
