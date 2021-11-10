//
//  Result.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation

public enum FlightResult<Success, Failure> {
    case success(Success, dataCount: Int = 0)
    case failure(Failure)
}
