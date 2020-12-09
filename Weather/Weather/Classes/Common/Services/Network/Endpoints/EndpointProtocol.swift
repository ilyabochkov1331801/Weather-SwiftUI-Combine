//
//  EndpointProtocol.swift
//  Weather
//
//  Created by Alena Nesterkina on 4.12.20.
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var key: String { get }
    var params: [String: String] { get }
}
