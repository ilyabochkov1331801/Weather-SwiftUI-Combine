//
//  APIProvider.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation
import Combine

class APIProvider<Endpoint: EndpointProtocol> {
    func getData(by endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        guard let request = performRequest(for: endpoint) else {
            return Fail(error: ApiProviderErrors.invalidUrl)
                .eraseToAnyPublisher()
        }
        return loadData(by: request)
            .eraseToAnyPublisher()
    }
    
    //MARK: - perform request
    private func performRequest(for endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        
        components.queryItems = endpoint.params.compactMap({ parameter -> URLQueryItem in
            return URLQueryItem(name: parameter.key, value: parameter.value)
        })
        
        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private func loadData(by request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error -> Error in
                error
            }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
