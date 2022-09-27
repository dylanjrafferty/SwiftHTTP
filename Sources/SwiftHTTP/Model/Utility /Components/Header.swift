//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Header: RequestComponent {
    
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    init(@HeaderBuilder builder: () -> Self) {
        let built = builder()
        self.key = built.key
        self.value = built.value
    }
    
    public func apply(to request: inout URLRequest) throws {
        request.addValue(key, forHTTPHeaderField: value)
    }
    
}

public struct KeyValue {
    let key: String
    let value: String
}
