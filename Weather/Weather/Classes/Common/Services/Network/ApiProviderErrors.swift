//
//  ApiErrors.swift
//  Weather
//
//  Created by Alena Nesterkina on 9.12.20.
//

import Foundation

enum ApiProviderErrors: Error {
    case invalidUrl
}

extension ApiProviderErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return L10n.invalidUrlKey
        }
    }
}
