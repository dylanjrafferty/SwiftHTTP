//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 8/13/22.
//

import Foundation

extension URLSession {
    func execute(_ request: URLRequest) async throws -> (Data?, URLResponse?) {
        try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: (data, urlResponse))
                }
            }
            task.resume()
        }
    }
}
