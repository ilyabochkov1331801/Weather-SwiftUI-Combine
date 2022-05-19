//
//  APIProvider.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

class APIProvider {
    func execute<Endpoint: EndpointProtocol>(endpoint: Endpoint) -> AnyPublisher<Endpoint.EndpointData.Target, Error> {
        guard let request = endpoint.asRequest() else {
            return Fail(error: APIProvider.Errors.invalidRequest)
                .eraseToAnyPublisher()
        }
        
        return request.execute()
            .decode(type: Endpoint.EndpointData.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return WeatherService.Errors.decodingError
                default:
                    return error
                }
            }
            .flatMap { $0.convert() }
            .receive(on: DispatchQueue.main)
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
