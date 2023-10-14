//
//  RequestError.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import Foundation

//MARK: - RequestErrors

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case noDataReceived
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .noDataReceived:
            return "Data received error"
        default:
            return "Unknown error"
        }
    }
}
