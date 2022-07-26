import XCTest
@testable import SwiftHTTP

@NetworkingActor final class SwiftHTTPTests: XCTestCase {
    
    
    func testEnvironmentOverride() throws {
        let request = OverrideRequest()
        XCTAssertEqual(request.baseURL, NetworkingEnvironmentValues().baseURL)
        let overridenRequest = OverrideRequest()
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Some New URL"))
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Overriden Again"))
            .networkingEnvironment(\.endpoint, "New Endpoint")
        XCTAssertEqual(overridenRequest.baseURL, URL(fileURLWithPath: "Overriden Again"))
        XCTAssertEqual(overridenRequest.endpoint, "New Endpoint")
    }
    
    func testMultipleOverrides() throws {
        let firstRequest = OverrideRequest()
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Some New URL"))
        let secondRequest = OverrideRequest()
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Newer URL"))
        XCTAssertEqual(firstRequest.baseURL,  URL(fileURLWithPath: "Some New URL"))
        XCTAssertEqual(secondRequest.baseURL, URL(fileURLWithPath: "Newer URL"))
    }
    
    func testGlobalOverrides() throws {
        SwiftHTTP.globalNetworkingEnvironment(BaseURL.self, URL(fileURLWithPath: "Global"))
        let firstRequest = OverrideRequest()
            .networkingEnvironment(\.baseURL, URL(fileURLWithPath: "Some New URL"))
        let secondRequest = OverrideRequest()
        XCTAssertEqual(firstRequest.baseURL,  URL(fileURLWithPath: "Some New URL"))
        XCTAssertEqual(secondRequest.baseURL, URL(fileURLWithPath: "Global"))
    }
    
    
}

fileprivate struct BaseURL: NetworkingEnvironmentKey {
    static var defaultValue: URL = URL(fileURLWithPath: "")
}

fileprivate extension NetworkingEnvironmentValues {
    var baseURL: URL {
        get { self[BaseURL.self] }
        set { self[BaseURL.self] = newValue }
    }
}

fileprivate class OverrideRequest: Requestable {
    
    typealias ResponseType = Response
    
    @NetworkingEnvironment(\.baseURL) var baseURL
    @NetworkingEnvironment(\.endpoint) var endpoint
    
    var request: Request {
        Request(url: baseURL) {
            
        }
    }
}

fileprivate struct Response: Decodable { }

fileprivate struct Endpoint: NetworkingEnvironmentKey {
    static var defaultValue: String = "example"
}

fileprivate extension NetworkingEnvironmentValues {
    var endpoint: String {
        get { self[Endpoint.self] }
        set { self[Endpoint.self] = newValue }
    }
}
