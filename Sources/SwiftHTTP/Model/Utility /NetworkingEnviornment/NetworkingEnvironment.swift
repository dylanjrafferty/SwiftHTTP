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
    private enum Source {
        case keyPath(KeyPath<NetworkingEnvironmentValues, Value>)
        case value(Value)
    }
    
    public var wrappedValue: Value {
        get {
            switch source {
            case .keyPath(let keyPath):
                return NetworkingEnvironmentValues()[keyPath: keyPath]
            case .value(let value):
                return value
            }
        }
    }

    private var source: Source

    init(_ keyPath: KeyPath<NetworkingEnvironmentValues, Value>) {
        self.source = .keyPath(keyPath)
    }
}

//extension Request {
//    func networkingEnvironment<Value>(_ keyPath: KeyPath<NetworkingEnvironmentValues, Value>, _ value: Value) -> Request {
//        
//    }
//}
/*
 
 There is one env that lives and provides default,
 on each request a custom dict lives with the overrides
 the propertywrapper checks if bound to request or should use default
 
 */




