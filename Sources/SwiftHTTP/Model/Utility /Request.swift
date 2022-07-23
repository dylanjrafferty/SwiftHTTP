//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Request {
    
    let components: [RequestComponent]
    let url: URL
    
    init(url: URL, @RequestBuilder builder: () -> [RequestComponent]) {
        self.url = url
        components = builder()
    }
    
    var request: URLRequest {
        get throws {
            var request = URLRequest(url: url)
            try components.forEach { try $0.apply(to: &request) }
            return request
        }
    }

}
