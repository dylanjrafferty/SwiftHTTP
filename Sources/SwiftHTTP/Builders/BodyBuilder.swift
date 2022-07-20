//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

@resultBuilder
public struct BodyBuilder {
    public static func buildBlock<T: Encodable>(_ body: T) -> Encodable {
       body
    }
    
}
