//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Body: RequestRepresentation {
    let bodyEncoding: BodyEncoding
    let body: Encodable
    
    init(encoding: BodyEncoding, body: Encodable) {
        self.bodyEncoding = encoding
        self.body = body
    }
 
    init(encoding: BodyEncoding, @BodyBuilder builder: () -> Encodable) {
        self.bodyEncoding = encoding
        self.body = builder()
    }
    
    public var requestComponent: RequestComponent {
        RequestComponent.body(self)
    }
}

public enum BodyEncoding {
    case json
}
