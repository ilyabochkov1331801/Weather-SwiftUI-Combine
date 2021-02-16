//
//  AppErrors.swift
//  Weather
//
//  Created by Alena Nesterkina on 12.02.21.
//

import Foundation

enum AppErrors: Error {
    case invalidSequence
}

extension AppErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidSequence:
            return "Something went wrong. Please check your internet connection."
        }
    }
}
