//
//  UserRequests.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

public enum LaunchRequests: Request {
    
    case all(page: Int, perPage: Int)
    case upcoming(page: Int, perPage: Int)
    case get(flightNumber: Int)

    public var path: String {
        switch self {
        case .all(_, _):
            return "launches"
        case .upcoming(_, _):
            return "launches/upcoming"
        case .get(let flightNumber):
            return "launches/\(flightNumber)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        case .upcoming:
            return .get
        case .get:
            return .get
        }
    }
    
    public var parameters: RequestParameters? {
        switch self {
        case .all(let page, let perPage):
            return .url(["limit": String(perPage),
                         "offset": String((page-1) * perPage)])
        case .upcoming(_, _):
            return .url([:])
        case .get(_):
            return .url([:])
        }
    }
    
    public var headers: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .all:
            return .data
        case .upcoming:
            return .data
        case .get:
            return .data
        }
    }
}
