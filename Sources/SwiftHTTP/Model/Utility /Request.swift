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
        var request = URLRequest(url: url)
        
//        components.forEach { component in
//            switch component {
//            case .header(let header): request.addValue(header.value, forHTTPHeaderField: header.key)
//            case .body: print("Handle body")
////                switch body.bodyEncoding {
////                case .json: request.httpBody = JSONEncoder().encode(body.body)
////                }
//            }
//        }
        
        return request
    }

}
