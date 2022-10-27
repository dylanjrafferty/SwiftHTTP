//
//  RetryRequestTests.swift
//  
//
//  Created by Dylan Rafferty on 10/27/22.
//

import XCTest
@testable import SwiftHTTP

final class RetryRequestTests: XCTestCase {

    func testRequestCompletes() async throws {
        guard let url = URL(string: "https://api.sampleapis.com/wines/reds") else {
            XCTFail("Invalid URL for the test.")
            return
        }
        
        let redWines = try await WineRequest()
            .networkingEnvironment(\.baseURL, url)()
        
        XCTAssertNotEqual(redWines.count, 0)
    }

}

fileprivate final class WineRequest: Requestable {

    @NetworkingEnvironment(\.baseURL) private var baseURL: URL

    typealias ResponseType = [Wine]

    var request: Request {
        Request(url: baseURL) {
            
        }
        .setMethod(.get)
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

fileprivate struct Wine: Decodable, Identifiable {
    let winery: String
    let wine: String
    let rating: Rating
    let location: String
    let image: String
    let id: Int
    
    var imageURL: URL? {
        URL(string: image)
    }
    
    struct Rating: Decodable {
        let average: String
        let reviews: String
    }
}
