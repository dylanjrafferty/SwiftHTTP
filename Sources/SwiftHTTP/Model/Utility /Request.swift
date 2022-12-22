//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Request: Sendable {
    
    let components: [RequestComponent]
    let url: URL
    
    public init(url: URL, @RequestBuilder builder: () -> [RequestComponent]) {
        self.url = url
        components = builder()
    }
    
    public init(url: URL, components: [RequestComponent]) {
        self.url = url
        self.components = components
    }
    
    var request: URLRequest {
        get throws {
            var request = URLRequest(url: url)
            try components.forEach { try $0.apply(to: &request) }
            return request
        }
    }

}

public struct RequestOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let highPriority = RequestOptions(rawValue: 1 << 0)
    public static let authorization = RequestOptions(rawValue: 1 << 1)
    public static let all: RequestOptions = [.highPriority, .authorization]
    public static let none: RequestOptions = []
}
