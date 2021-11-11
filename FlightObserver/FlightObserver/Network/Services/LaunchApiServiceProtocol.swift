//
//  LaunchApiServiceProtocol.swift
//  FlightObserver
//
//  Created by Furkan Torun on 10.11.2021.
//

import Foundation
import Alamofire

public protocol LaunchApiServiceProtocol {
    func fetchUpcomingLaunchs(completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void)
    func fetchAllLaunchs(page: Int, perPage: Int, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void)
    func fetchLaunch(flightNumber: Int, completion: @escaping (FlightResult<LaunchDetail, Error>) -> Void)    
}
