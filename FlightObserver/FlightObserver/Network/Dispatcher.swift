//
//  Dispatcher.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Alamofire
import Foundation

protocol Dispatcher {

    init(environment: Environment)
    
    /// This function execute the request and provide a completion handler with the response
    ///
    /// - Parameters:
    ///   - request: request to execute
    ///   - completion: completion handler for the request
    /// - Throws: error
    func execute(request: Request, completion: @escaping (_ response: Response) -> Void) throws
}
