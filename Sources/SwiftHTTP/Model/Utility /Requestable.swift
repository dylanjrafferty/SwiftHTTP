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
    
    @NetworkingActor var isRefreshing = false
    @NetworkingActor var environmentOverrides = [AnyHashable: NetworkingEnvironmentValues]()
}

@NetworkingActor public protocol Requestable: AnyObject, Identifiable {
    associatedtype ResponseType: Decodable
    var request: Request { get }
    nonisolated var requestOptions: RequestOptions { get }
}

extension Requestable {
    var _overrides: NetworkingEnvironmentValues {
        get {
            NetworkingActor.shared.environmentOverrides[id] ?? NetworkingEnvironmentValues()
        }
        set {
            NetworkingActor.shared.environmentOverrides[id] = newValue
        }
    }
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
    func decode<T>(_ type: T.Type, from: Data) throws -> T
}

extension Requestable {
    
    @discardableResult
    nonisolated func callAsFunction(decodingType: DecodingType = .json) async throws -> ResponseType {
        
        if requestOptions != .authorization {
            await waitForRefresh()
        }
        
        let (data, _) = try await URLSession.shared.execute(request.request)
        
        guard let data = data else { throw NetworkingError.invalidData }
        
        return try decode(data, decodingType: decodingType)
    }
    
    nonisolated func decode(_ data: Data, decodingType: DecodingType) throws -> ResponseType {
        switch decodingType {
        case .json:
            return try JSONDecoder().decode(ResponseType.self, from: data)
        case .custom(let decoder):
            return try decoder.decode(ResponseType.self, from: data)
        }
    }
    
    @NetworkingActor func waitForRefresh() async {
        // Return when refreshing has stopped
    }
}
