//
//  UsersOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UpcomingLaunchsOperationType {
    var request: Request { get }
    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void)
}

final class UpcomingLaunchsOperation: Operation, UpcomingLaunchsOperationType {

    typealias D = Dispatcher
    typealias R = [LaunchDetail]

    // MARK: Request parameters
    
    init() {
    }
    
    var request: Request {
        LaunchRequests.upcoming(page: 0, perPage: 0)
    }

    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void) {
        self.executeBaseArrayResponse(dispatcher: dispatcher, completion: completion)
     }
}
