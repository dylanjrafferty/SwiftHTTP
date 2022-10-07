//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 10/6/22.
//

import Foundation

@resultBuilder
public struct QueryBuilder {
    
    public static func buildBlock(_ components: KeyValue...) -> [KeyValue] {
        components
    }
    
    public static func buildExpression(_ expression: KeyValue) -> [KeyValue] {
        [expression]
    }
    
    public static func buildOptional(_ component: [KeyValue]?) -> [KeyValue] {
        component ?? []
    }
    
    public static func buildEither(first component: [KeyValue]) -> [KeyValue] {
        component
    }
    
    public static func buildEither(second component: [KeyValue]) -> [KeyValue] {
        component
    }
    
    public static func buildFinalResult(_ component: [KeyValue]) -> [KeyValue] {
        component
    }
    
    public static func buildArray(_ components: [[KeyValue]]) -> [KeyValue] {
        components.flatMap { $0 }
    }
}
