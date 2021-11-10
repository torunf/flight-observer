//
//  LaunchApi.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation
import Alamofire

class LaunchApiService : LaunchApiServiceProtocol {

    private(set) var dispatcher: Dispatcher
    private(set) var allLaunchsOperation: AllLaunchsOperationType
    private(set) var upcomingLaunchsOperation: UpcomingLaunchsOperationType
    private(set) var getLaunchOperation: GetLaunchOperationType
    
    public enum FlightError: Swift.Error {
        case parameterParsingError(internal: Swift.Error)
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }

    public init() {
        self.dispatcher = NetworkDispatcher(environment: Utils.Env.SpaceX)
        self.allLaunchsOperation = AllLaunchsOperation()
        self.upcomingLaunchsOperation = UpcomingLaunchsOperation()
        self.getLaunchOperation = GetLaunchOperation()
    }

    func fetchUpcomingLaunchs(completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void) {
        upcomingLaunchsOperation.execute(in: dispatcher) { result in
            switch result {
            case .success(let response, _):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(FlightError.networkError(internal: error)))
            }
        }
    }

    func fetchAllLaunchs(page: Int, perPage: Int, completion: @escaping (FlightResult<[LaunchDetail], Error>) -> Void) {
        allLaunchsOperation.page = page
        allLaunchsOperation.perPage = perPage
        allLaunchsOperation.execute(in: dispatcher) { result in
            switch result {
            case .success(let response, let dataCount):
                completion(.success(response, dataCount: dataCount))
            case .failure(let error):
                completion(.failure(FlightError.networkError(internal: error)))
            }
        }
    }

    func fetchLaunch(flightNumber: Int, completion: @escaping (FlightResult<LaunchDetail, Error>) -> Void) {
        getLaunchOperation.flightNumber = flightNumber
        getLaunchOperation.execute(in: dispatcher) { result in
            switch result {
            case .success(let response, _):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(FlightError.networkError(internal: error)))
            }
        }
    }
    
}
