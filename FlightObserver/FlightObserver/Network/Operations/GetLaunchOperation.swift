//
//  LaunchsOperation.swift
//  FlightObserver
//
//  Created by Furkan Torun on 11.11.2021.
//

import Foundation
import AVFoundation

protocol GetLaunchOperationType {
    var flightNumber: Int { get set }
    var request: Request { get }
    init(flightNumber: Int)
    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<LaunchDetail, Error>) -> Void)
}

final class GetLaunchOperation: Operation, GetLaunchOperationType {
    
    typealias D = Dispatcher
    typealias R = LaunchDetail
    
    // MARK: Request parameters
    var flightNumber: Int
    
    init() {
        self.flightNumber = 0
    }
    
    init(flightNumber: Int) {
        self.flightNumber = flightNumber
    }
    
    var request: Request {
        LaunchRequests.get(flightNumber: flightNumber)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<LaunchDetail, Error>) -> Void) {
        self.executeBaseResponse(dispatcher: dispatcher, completion: completion)
    }
}
