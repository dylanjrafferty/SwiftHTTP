//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 12/22/22.
//

import Foundation

public final class GETRequest: Requestable {
    
    let url: URL
    let requestComponents: [RequestComponent]
    
    public init(url: URL, @RequestBuilder builder: () -> [RequestComponent]) {
        self.url = url
        self.requestComponents = builder()
    }
    
    public typealias ResponseType = Data
    
    public var request: Request {
        Request(url: url, components: requestComponents)
            .setMethod(.get)
    }
}
