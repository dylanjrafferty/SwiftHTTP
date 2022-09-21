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
        message: "@NetworkingEnvironment can only be used within classes that conform to Requestable"
    )
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    public static subscript<R: Requestable>(
          _enclosingInstance instance: R,
          wrapped wrappedKeyPath: ReferenceWritableKeyPath<R, Value>,
          storage storageKeyPath: ReferenceWritableKeyPath<R, Self>
        ) -> Value {
        get {
            instance._overrides[keyPath: instance[keyPath: storageKeyPath].keyPath]
        }
        set {
            var overrides = instance._overrides
            overrides[keyPath: instance[keyPath: storageKeyPath].keyPath] = newValue
            instance._overrides = overrides
        }
    }

    private let keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>

    init(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}

extension Requestable {
    @NetworkingActor func networkingEnvironment<Value>(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>, _ value: Value) -> Self {
        var mutableOverrides = NetworkingActor.shared.environmentOverrides[request] ?? NetworkingEnvironmentValues()
        mutableOverrides[keyPath: keyPath] = value
        NetworkingActor.shared.environmentOverrides[request] = mutableOverrides
        return self
    }
}
