//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 8/13/22.
//

import Foundation

@globalActor
final actor NetworkingActor {
    public static var shared = NetworkingActor()
}

extension NetworkingActor {
    static var isRefreshing = false
}

@NetworkingActor protocol Requestable {
    associatedtype ResponseType: Decodable
    var request: Request { get }
    var requestOptions: RequestOptions { get }
}

@NetworkingActor extension Requestable {
    var requestOptions: RequestOptions {
        .none
    }
}

public enum DecodingType {
    case json
    case custom(CustomDecoder)
}

public protocol CustomDecoder {
    func decode<T>(_ type: T.Type, from: Data) throws -> T
}

@NetworkingActor extension Requestable {
    
    @discardableResult
    func callAsFunction(decodingType: DecodingType = .json) async throws -> ResponseType {
        let (data, _) = try await URLSession.shared.execute(request.request)
        
        switch decodingType {
        case .json:
            guard let data = data else { throw NetworkingError.invalidData }
            return try JSONDecoder().decode(ResponseType.self, from: data)
        case .custom(let decoder):
            guard let data = data else { throw NetworkingError.invalidData }
            return try decoder.decode(ResponseType.self, from: data)
        }
    }
}
