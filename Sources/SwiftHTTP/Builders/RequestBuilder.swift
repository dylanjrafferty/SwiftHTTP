//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

@resultBuilder
public struct RequestBuilder {
    public static func buildBlock(_ url: URL, _ components: RequestRepresentation...) -> Request {
        let requestComponents = components.map { $0.requestComponent }
        return Request(url: url, components: requestComponents)
    }
}
