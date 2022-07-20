//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 7/19/22.
//

import Foundation

@resultBuilder
public struct RequestBuilder {
    public static func buildBlock(_ url: URL, _ body: Body, _ headers: Header...) -> Request {
        Request(body: body, headers: headers, url: url)
    }
}
