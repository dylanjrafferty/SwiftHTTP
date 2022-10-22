//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 8/13/22.
//

import Foundation

@globalActor
public final actor NetworkingActor {
    public static var shared = NetworkingActor()
    @NetworkingActor var globalEnvironmentOverrides = [ObjectIdentifier: Any]()
    @NetworkingActor var environmentOverrides = [AnyHashable: NetworkingEnvironmentValues]()
}

@NetworkingActor public protocol Requestable: AnyObject, Identifiable {
    associatedtype ResponseType: Decodable
    var request: Request { get }
    nonisolated var requestOptions: RequestOptions { get }
}

public extension Requestable {
    var requestOptions: RequestOptions {
        .none
    }
}

public enum DecodingType {
    case json
    case custom(CustomDecoder)
}

public protocol CustomDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension Requestable {
    
    @discardableResult
    nonisolated public func callAsFunction(decodingType: DecodingType = .json, attempt: Int = 0) async throws -> ResponseType {
        let (data, _) = try await NetworkingEnvironmentValues().defaultURLSession.execute(request.request)
        guard let data = data else { throw NetworkingError.invalidData }
        
        return try decode(data, decodingType: decodingType)
    }
    
    nonisolated private func decode(_ data: Data, decodingType: DecodingType) throws -> ResponseType {
        switch decodingType {
        case .json:
            return try JSONDecoder().decode(ResponseType.self, from: data)
        case .custom(let decoder):
            return try decoder.decode(ResponseType.self, from: data)
        }
    }
}
