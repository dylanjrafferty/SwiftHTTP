//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public struct Header {
    
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
    
}

public struct KeyValue {
    let key: String
    let value: String
}
