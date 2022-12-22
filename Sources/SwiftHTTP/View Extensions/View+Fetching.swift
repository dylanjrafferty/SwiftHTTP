//
//  File.swift
//  
//
//  Created by Dylan Rafferty on 12/22/22.
//

import Foundation
import SwiftUI

extension View {
    public func fetching<T: Decodable, R: Requestable>(_ binding: Binding<T>, _ request: @escaping @NetworkingActor () -> R) -> some View where R.ResponseType == Data {
        task {
            if let data = try? await request().callAsFunction(), let value = try? JSONDecoder().decode(T.self, from: data) {
                binding.wrappedValue = value
            }
        }
    }
}
