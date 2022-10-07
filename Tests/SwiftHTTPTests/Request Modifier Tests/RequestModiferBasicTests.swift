//
//  RequestModiferBasicTests.swift
//  
//
//  Created by Dylan Rafferty on 10/6/22.
//

import XCTest
@testable import SwiftHTTP

final class RequestModiferBasicTests: XCTestCase {

    func testAllHTTPMethodSet() throws {
        let getRequest = Request(url: URL(fileURLWithPath: ""), components: [])
            .setMethod(.get)
        
        let patchRequest = Request(url: URL(fileURLWithPath: ""), components: [])
            .setMethod(.patch)
        
        let postRequest = Request(url: URL(fileURLWithPath: ""), components: [])
            .setMethod(.post)
        
        XCTAssertNotNil(try getRequest.request.httpMethod)
        XCTAssertNotNil(try patchRequest.request.httpMethod)
        XCTAssertNotNil(try postRequest.request.httpMethod)
    }

}
