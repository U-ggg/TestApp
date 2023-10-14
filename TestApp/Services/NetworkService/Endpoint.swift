//
//  Endpoints.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import Foundation

//MARK: - Endpoint protocol

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var item: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "itunes.apple.com" }
}
