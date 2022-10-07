//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

@resultBuilder
public struct RequestBuilder {
    
    public static func buildFinalResult(_ component: [RequestComponent]) -> [RequestComponent] {
        component
    }
    
    public static func buildExpression<T: Encodable>(_ expression: Body<T>) -> RequestComponent {
        expression
    }
    
    public static func buildExpression(_ expression: Header) -> RequestComponent {
        expression
    }
    
    public static func buildExpression(_ expression: QueryParameter) -> RequestComponent {
        expression
    }
    
    public static func buildBlock(_ components: RequestComponent...) -> [RequestComponent] {
        components
    }
    
    public static func buildEither(first component: [RequestComponent]) -> [RequestComponent] {
        component
    }
    
    public static func buildEither(second component: [RequestComponent]) -> [RequestComponent] {
        component
    }
    
    public static func buildArray(_ components: [[RequestComponent]]) -> [RequestComponent] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [RequestComponent]?) -> [RequestComponent] {
        component ?? []
    }
    
    public static func buildOptional(_ component: RequestComponent?) -> [RequestComponent] {
        if let component {
            return [component]
        } else {
            return []
        }
    }

}
