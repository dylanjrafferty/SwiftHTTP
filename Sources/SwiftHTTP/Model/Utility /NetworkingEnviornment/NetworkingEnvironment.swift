//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 8/13/22.
//

import Foundation

public protocol NetworkingEnvironmentKey {
    associatedtype Value
    
    static var defaultValue: Self.Value { get }
}

public struct NetworkingEnvironmentValues {
    
    public subscript<K: NetworkingEnvironmentKey>(key: K.Type) -> K.Value {
        get {
            K.defaultValue
        }
    }
}

private struct BaseURL: NetworkingEnvironmentKey {
    static var defaultValue: URL = URL(fileURLWithPath: "")
}

extension NetworkingEnvironmentValues {
    var baseURL: URL {
        get { self[BaseURL.self] }
    }
}

@propertyWrapper
public struct NetworkingEnvironment<Value> {
    
    public var wrappedValue: Value {
        get {
            NetworkingEnvironmentValues()[keyPath: keyPath]
        }
    }

    let keyPath: KeyPath<NetworkingEnvironmentValues, Value>

    init(_ keyPath: KeyPath<NetworkingEnvironmentValues, Value>) {
        self.keyPath = keyPath
    }

}
