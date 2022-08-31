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
    
    static let shared = NetworkingEnvironmentValues()
    
    private var overrides = [ObjectIdentifier: Any]()
    
    public subscript<K: NetworkingEnvironmentKey>(key: K.Type) -> K.Value {
        get {
            guard let value = overrides[ObjectIdentifier(key)] as? K.Value else {
                return K.defaultValue
            }
            return value
        }
        set {
            overrides[ObjectIdentifier(key)] = newValue
        }
    }
}

private struct BaseURL: NetworkingEnvironmentKey {
    static var defaultValue: URL = URL(fileURLWithPath: "")
}

extension NetworkingEnvironmentValues {
    var baseURL: URL {
        get { self[BaseURL.self] }
        set { self[BaseURL.self] = newValue }
    }
}

@propertyWrapper public struct NetworkingEnvironment<Value> {
    
    public var wrappedValue: Value {
        get {
            NetworkingEnvironmentValues()[keyPath: keyPath]
        }
    }

    private let keyPath: KeyPath<NetworkingEnvironmentValues, Value>

    init(_ keyPath: KeyPath<NetworkingEnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}

//extension Request {
//    func networkingEnvironment<Value>(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>, _ value: Value) -> Request {
//
//    }
//}
/*
 
 There is one env that lives and provides default,
 on each request a custom dict lives with the overrides
 the propertywrapper checks if bound to request or should use default
 
 */




