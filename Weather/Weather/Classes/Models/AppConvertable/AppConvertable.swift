//
//  AppConvertable.swift
//  Weather
//
//  Created by Илья Бочков  on 4.12.20.
//

import Combine

protocol AppConvertable {
    associatedtype Target: AppConvertableTarget
    func convert() -> AnyPublisher<Target, Never>
}
