//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 10/6/22.
//

import Foundation

public extension Request {
    func setMethod(_ method: HTTPMethod) -> Self {
        Request(url: url, components: components + [method])
    }
}

public enum HTTPMethod: RequestComponent {
    case get
    case post
    case patch
    
    public func apply(to request: inout URLRequest) throws {
        switch self {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        case .patch:
            request.httpMethod = "PATCH"
        }
    }
}
