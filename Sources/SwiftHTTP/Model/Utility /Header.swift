//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

public protocol RequestRepresentation {
    var requestComponent: RequestComponent { get }
}

public struct Header: RequestRepresentation {
    
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
    
    public var requestComponent: RequestComponent {
        RequestComponent.header(self)
    }
    
}

public struct KeyValue {
    let key: String
    let value: String
}
