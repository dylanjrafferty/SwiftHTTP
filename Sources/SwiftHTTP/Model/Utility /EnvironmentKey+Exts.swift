//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 9/28/22.
//

import Foundation

struct DefaultURLSession: NetworkingEnvironmentKey {
    static var defaultValue: URLSession = URLSession.shared
}

extension NetworkingEnvironmentValues {
    var defaultURLSession: URLSession {
        get { self[DefaultURLSession.self] }
        set { self[DefaultURLSession.self] = newValue }
    }
}

struct RetryAttempts: NetworkingEnvironmentKey {
    static var defaultValue: Int = 3
}

extension NetworkingEnvironmentValues {
    var retryAttempts: Int {
        get { self[RetryAttempts.self] }
        set { self[RetryAttempts.self] = newValue }
    }
}

