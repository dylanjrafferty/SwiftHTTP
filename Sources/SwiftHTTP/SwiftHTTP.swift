import Foundation

@globalActor
final actor NetworkingActor {
    public static var shared = NetworkingActor()
    
    
}

enum NetworkingError: Error {
    case invalidData
}

struct Sample: Requestable {

    @NetworkingEnvironment(\.baseURL) private var specialURL: URL
    
    typealias ResponseType = Response
    
    var request: Request {
        Request(url: URL(fileURLWithPath: "Testing123")) {
            Body(encoding: .json) {
                Data()
            }
            
            Header {
                KeyValue(key: "Authorization", value: "Bearer asdasdfdsads")
            }
        }
    }
}

let example = Task { @NetworkingActor in
    let sampleRequest = Sample()
    let example = try await sampleRequest()
}

struct Response: Decodable {
    
}
