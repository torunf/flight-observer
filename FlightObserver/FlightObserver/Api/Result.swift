//
//  Result.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation

public enum Result<Value> {
    case success(Value,_ count: Int = 0)
    case failure(Error)
}
