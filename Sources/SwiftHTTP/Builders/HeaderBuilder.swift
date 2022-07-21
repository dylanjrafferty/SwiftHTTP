//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

@resultBuilder
public struct HeaderBuilder {
    public static func buildBlock(_ keyValue: KeyValue) -> Header {
        Header(key: keyValue.key, value: keyValue.value)
    }
}

public enum RequestComponent {
    case header(Header)
    case body(Body)
    case url(URL)
}
