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

struct Sample: Requestable {
    
//    @Networking(\.isRefreshing) private var isRefreshing: Bool
//    @Networking(\.specialURL) private var specialURL: URL
    
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
    
    func test() {
        Sample()()
    }
}

//let healthyAction = await Request<Response> {
//
//}

struct Response {
    
}
