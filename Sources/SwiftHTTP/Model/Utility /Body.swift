//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Body<T: Encodable>: RequestComponent {
    
    let bodyEncoding: BodyEncoding
    let body: T
    
    private var data: Data {
        get throws {
            switch bodyEncoding {
            case .json:
                return try JSONEncoder().encode(body)
            }
        }
    }
    
    init(encoding: BodyEncoding, body: T) {
        self.bodyEncoding = encoding
        self.body = body
    }
 
    init(encoding: BodyEncoding, @BodyBuilder builder: () -> T) {
        self.bodyEncoding = encoding
        self.body = builder()
    }
    
    public func apply(to request: inout URLRequest) throws {
        guard let body = try? data else { throw RequestBuilderError.bodyFailedToEncode }
        if let currentData = request.httpBody {
            let appendedData = currentData + body
            request.httpBody = appendedData
        } else {
            request.httpBody = body
        }
    }

}

public enum BodyEncoding {
    case json
}
