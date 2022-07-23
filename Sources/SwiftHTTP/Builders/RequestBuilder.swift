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
    
//    public static func buildFinalResult(_ component: [RequestComponent]) -> () async -> Void {
//        
//    }
    
    public static func buildExpression<T: Encodable>(_ expression: Body<T>) -> RequestComponent {
        expression
    }
    
    public static func buildExpression(_ expression: Header) -> RequestComponent {
        expression
    }
    
    public static func buildBlock(_ components: RequestComponent...) -> [RequestComponent] {
        components
    }

}
