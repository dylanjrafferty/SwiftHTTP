import XCTest
@testable import SwiftHTTP

final class SwiftHTTPTests: XCTestCase {
    
    
    @NetworkingActor func testEnvironmentOverride() throws {
        let request = OverrideRequest()
        XCTAssertEqual(request.baseURL, NetworkingEnvironmentValues().baseURL)
        let overridenRequest = OverrideRequest()
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Some New URL"))
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Overriden Again"))
        XCTAssertEqual(overridenRequest.baseURL, URL(fileURLWithPath: "Overriden Again"))
    }
}

fileprivate struct OverrideRequest: Requestable {
    
    typealias ResponseType = Response
    
    @NetworkingEnvironment(\.baseURL) var baseURL
    
    var request: Request {
        Request(url: baseURL) {
            
        }
    }
}

fileprivate struct Response: Decodable { }
