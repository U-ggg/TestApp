//
//  ItunesEndpoint.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import Foundation

//MARK: - ItunesEndpoint

enum ItunesEndpoint {
    case searchTrack
}

//MARK: - extension ItunesEndpoint

extension ItunesEndpoint: Endpoint {
    
    var path: String {
        switch self {
            
        case .searchTrack:
            return Constants.path
        }
    }
    
    var method: RequestMethod {
        switch self {
            
        case .searchTrack:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var item: [URLQueryItem]? {
        nil
    }
}
