//
//  Environment.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

struct Utils {
    struct Env {
        static let SpaceX = Environment("SpaceX API", host: "https://api.spacexdata.com/v3")
    }
}

public struct Environment {
    
    public var name: String
    public var host: String
    public var headers: [String: Any] = ["Content-Type": "application/json"]
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    /// Initialize a new Environment
    ///
    /// - Parameters:
    ///   - name: name of the environment
    ///   - host: base url
    public init(_ name: String, host: String) {
        self.name = name
        self.host = host
    }
}
