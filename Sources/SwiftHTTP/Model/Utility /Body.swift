//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Body {
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
}

public enum BodyEncoding {
    case json
}
