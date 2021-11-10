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

/// Environment is a struct which encapsulate all the informations we need to perform a setup of our Networking Layer.
public struct Environment {
    
    /// Name of the environment
    public var name: String
    
    /// Base URL of the environment
    public var host: String
    
    /// This is the list of common headers which will be part of each Request
    /// Headers may be overwritten by specific Request's implementation
    public var headers: [String: Any] = ["Content-Type": "application/json"]
    
    /// Cache policy
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
