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

@NetworkingActor @propertyWrapper public struct NetworkingEnvironment<Value> {
    
    @available(*, unavailable,
        message: "@NetorkingEnvironment can only be used within classes"
    )
    public var wrappedValue: Value {
        get {
            fatalError()
        }
        set {
            fatalError()
        }
    }
    
    public static subscript<R: Requestable>(
          _enclosingInstance instance: R,
          wrapped wrappedKeyPath: ReferenceWritableKeyPath<R, Value>,
          storage storageKeyPath: ReferenceWritableKeyPath<R, Self>
        ) -> Value {
        get {
            instance.request.overrides[keyPath: instance[keyPath: storageKeyPath].keyPath]
        }
        set {
            fatalError()
//            instance.request.overrides[keyPath: instance[keyPath: storageKeyPath].keyPath] = newValue
        }
    }

    private let keyPath: KeyPath<NetworkingEnvironmentValues, Value>

    init(_ keyPath: KeyPath<NetworkingEnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}

extension Requestable {
    @NetworkingActor func networkingEnvironment<Value>(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>, _ value: Value) -> Self {
//        var mutableOverrides = request.overrides
//        mutableOverrides[keyPath: keyPath] = value
//        request.overrideEnvironment(mutableOverrides)
        return self
    }
}

/*
 
 There is one env that lives and provides default,
 on each request a custom dict lives with the overrides
 the propertywrapper checks if bound to request or should use default
 
 */




