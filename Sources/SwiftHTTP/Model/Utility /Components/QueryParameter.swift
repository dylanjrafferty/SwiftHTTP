//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 9/26/22.
//

import Foundation

public struct QueryParameter: RequestComponent {
    
    let components: [KeyValue]
    
    private var queryItems: [URLQueryItem] {
        components.map { pair in
            URLQueryItem(name: pair.key, value: pair.value)
        }
    }
    
    init(@QueryBuilder builder: () -> [KeyValue]) {
        self.components = builder()
    }
    
    public func apply(to request: inout URLRequest) throws {
        try request.append(queryItems)
    }
}

extension URLRequest {
    
    mutating func append(_ queryItems: [URLQueryItem]) throws {
        if #available(iOS 16.0, *) {
            url?.append(queryItems: queryItems)
        } else {
            guard let unwrappedURL = url else { throw QueryEncodingError.nilURL }
            guard var urlComponents = URLComponents(string: unwrappedURL.absoluteString) else { throw QueryEncodingError.unableToCreateComponents }
            urlComponents.queryItems = queryItems
            guard let createdURL = urlComponents.url else { throw QueryEncodingError.unableToCreateURL }
            url = createdURL
        }
    }
}

fileprivate enum QueryEncodingError: Error {
    case nilURL
    case unableToCreateComponents
    case unableToCreateURL
}
