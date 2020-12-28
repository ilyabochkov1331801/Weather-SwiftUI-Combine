//
//  APIProvider.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

class APIProvider<Endpoint: EndpointProtocol> {
    func getData(by endpoint: Endpoint) -> AnyPublisher<Endpoint.EndpointData.Target, Error> {
        guard let request = endpoint.asRequest() else {
            return Fail(error: APIProvider.Errors.invalidRequest)
                .eraseToAnyPublisher()
        }
        return request.execute()
            .decode(type: Endpoint.EndpointData.self, decoder: JSONDecoder())
            .flatMap { $0.convert() }
            .eraseToAnyPublisher()
    }
}

extension APIProvider {
    enum Errors: Error, LocalizedError {
        case invalidRequest
        
        var errorDescription: String? {
            switch self {
            case .invalidRequest:
                return L10n.invalidRequestKey
            }
        }
    }
}
