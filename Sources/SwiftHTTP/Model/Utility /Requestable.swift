//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 8/13/22.
//

import Foundation

@globalActor
public final actor NetworkingActor {
    public static let shared = NetworkingActor()
    @NetworkingActor var globalEnvironmentOverrides = [ObjectIdentifier: Any]()
    @NetworkingActor var environmentOverrides = [AnyHashable: NetworkingEnvironmentValues]()
}

@NetworkingActor public protocol Requestable: AnyObject, Identifiable {
    associatedtype ResponseType: Decodable & Sendable
    var request: Request { get }
    nonisolated var requestOptions: RequestOptions { get }
}

public extension Requestable {
    var requestOptions: RequestOptions {
        .none
    }
}

public enum DecodingType: Sendable {
    case json
    case custom(CustomDecoder)
}

public protocol CustomDecoder: Sendable {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension Requestable {
    
    @discardableResult
    nonisolated public func callAsFunction(decodingType: DecodingType = .json) async throws -> ResponseType {
        let urlRequest = try await request.request
        return try await Task.retrying(maxRetryCount: NetworkingEnvironmentValues().retryAttempts) { @Sendable in
            let (data, _) = try await NetworkingEnvironmentValues().defaultURLSession.execute(urlRequest)
            guard let data = data else { throw NetworkingError.invalidData }
            
            switch decodingType {
            case .json:
                return try JSONDecoder().decode(ResponseType.self, from: data)
            case .custom(let decoder):
                return try decoder.decode(ResponseType.self, from: data)
            }
        }
        .value
    }
    
    @discardableResult
    nonisolated public func execute(decodingType: DecodingType = .json) async throws -> ResponseType {
        try await callAsFunction(decodingType: decodingType)
    }
}
