//
//  Endpoint.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import Foundation

private enum HTTPMethod: String {
    case get
    case put
    case post
    case delete
}

enum Endpoint {
    
    case getCharacters
    
    private var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    private var baseURL: URL {
        guard let baseURL = URL(string: "https://breakingbadapi.com/api/") else {
            fatalError("baseURL nil")
        }
        return baseURL
    }
    
    private var path: String {
        switch self {
        case .getCharacters:
            return "characters"
        }
    }
    
    public var urlRequest: URLRequest? {
        guard let requestURL = URL(string: baseURL.appendingPathComponent(path).absoluteString) else {
            return nil
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue

        return request
    }
}
