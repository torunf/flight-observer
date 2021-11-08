//
//  LaunchApi.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation
import Alamofire

public protocol LaunchApiServiceProtocol {
    func fetchUpcomingLaunchs(completion: @escaping (Result<[LaunchDetail]>) -> Void)
    func fetchAllLaunchs(completion: @escaping (Result<[LaunchDetail]>) -> Void)
}

class LaunchApiService : LaunchApiServiceProtocol {
    
    public enum Error: Swift.Error {
        case parameterParsingError(internal: Swift.Error)
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() {}
    func fetchUpcomingLaunchs( completion: @escaping (Result<[LaunchDetail]>) -> Void) {
        let urlString = "https://api.spacexdata.com/v3/launches/upcoming"
        var request = URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let response = try decoder.decode([LaunchDetail].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
    func fetchAllLaunchs( completion: @escaping (Result<[LaunchDetail]>) -> Void) {
        let urlString = "https://api.spacexdata.com/v3/launches"
        var request = URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let response = try decoder.decode([LaunchDetail].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
    
}
