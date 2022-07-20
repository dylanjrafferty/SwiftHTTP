//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Request {
    
    let body: Body?
    let headers: [Header]?
    let url: URL
    
    init(body: Body, headers: [Header], url: URL) {
        self.body = body
        self.headers = headers
        self.url = url
    }
    
    init(@RequestBuilder builder: () -> Self) {
        let built = builder()
        self.body = built.body
        self.headers = built.headers
        self.url = built.url
    }

}
