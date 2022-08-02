import Foundation

@globalActor
final actor NetworkingActor {
    public static var shared = NetworkingActor()
}

@NetworkingActor protocol Requestable {
    associatedtype responseType
    @RequestBuilder var request: Request { get }
}

extension Requestable {
    func callAsFunction() -> Data {
        Data()
    }
}

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

struct Sample: Requestable {
    
//    @Networking(\.isRefreshing) private var isRefreshing: Bool
    @NetworkingEnvironment(\.baseURL) private var specialURL: URL
    
    typealias responseType = Response
    
    var request: Request {
        return Request(url: URL(fileURLWithPath: "Testing123")) {
            Body(encoding: .json) {
                Data()
            }
            
            Header {
                KeyValue(key: "Authorization", value: "Bearer asdasdfdsads")
            }
        }
    }
}

//let healthyAction = await Request<Response> {
//
//}

struct Response {
    
}
