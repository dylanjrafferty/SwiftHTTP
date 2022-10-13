import Foundation

public enum SwiftHTTP {
    
    @NetworkingActor static func globalNetworkingEnvironment<K: NetworkingEnvironmentKey>(_ key: K.Type, _ newValue: K.Value) {
        NetworkingActor.shared.overrides[ObjectIdentifier(key)] = newValue
    }
}

enum NetworkingError: Error {
    case invalidData
}
