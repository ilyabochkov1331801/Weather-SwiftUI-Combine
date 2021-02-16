//
//  EndpointProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation

protocol EndpointProtocol {
    associatedtype EndpointData: AppConvertable
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var key: String { get }
    var params: [String: String] { get }
}

extension EndpointProtocol {
    func asRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = params.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        print(components.url?.absoluteURL)
        return components.url.flatMap { URLRequest(url: $0) }
    }
}
