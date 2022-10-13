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

@NetworkingActor public struct NetworkingEnvironmentValues {
    
    var overrides = [ObjectIdentifier: Any]()
    
    public subscript<K: NetworkingEnvironmentKey>(key: K.Type) -> K.Value {
        get {
            if let value = overrides[ObjectIdentifier(key)] as? K.Value {
                return value
            } else if let value = NetworkingActor.shared.globalEnvironmentOverrides[ObjectIdentifier(key)] as? K.Value {
                return value
            } else {
                return K.defaultValue
            }
        }
        set {
            overrides[ObjectIdentifier(key)] = newValue
        }
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

    public init(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}

public extension Requestable {
    @NetworkingActor func networkingEnvironment<Value>(_ keyPath: WritableKeyPath<NetworkingEnvironmentValues, Value>, _ value: Value) -> Self {
        var mutableOverrides = _overrides
        mutableOverrides[keyPath: keyPath] = value
        _overrides = mutableOverrides
        return self
    }
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
