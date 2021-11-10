//
//  UserDetailOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation
import AVFoundation

protocol AllLaunchsOperationType {
    var page: Int { get set }
    var perPage: Int { get set }
    var request: Request { get }

    init(page: Int, perPage: Int)
    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void)
}

final class AllLaunchsOperation: Operation, AllLaunchsOperationType {

    typealias D = Dispatcher
    typealias R = [LaunchDetail]
    
    // MARK: Request parameters
    var page: Int
    var perPage: Int
    
    init() {
        self.page = 0
        self.perPage = 0
    }
    
    init(page: Int, perPage: Int) {
        self.page = page
        self.perPage = perPage
    }
    
    var request: Request {
        LaunchRequests.all(page: page, perPage: perPage)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void) {
        self.executeBaseArrayResponse(dispatcher: dispatcher, completion: completion)
    }
}
