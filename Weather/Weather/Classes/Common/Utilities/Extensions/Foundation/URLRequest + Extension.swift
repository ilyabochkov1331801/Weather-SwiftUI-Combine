//
//  URLRequest + Extension.swift
//  Weather
//
//  Created by Alena Nesterkina on 25.12.20.
//

import Combine
import Foundation

extension URLRequest {
    func execute(at session: URLSession = .shared) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: self)
            .mapError { $0 }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
