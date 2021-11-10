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
    func fetchAllLaunchs(page: Int, perPage: Int, completion: @escaping (Result<[LaunchDetail]>) -> Void)
}

class LaunchApiService : LaunchApiServiceProtocol {
    
    let baseUrlString: String

    public enum Error: Swift.Error {
        case parameterParsingError(internal: Swift.Error)
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() {
        baseUrlString = "https://api.spacexdata.com/v3/"
    }
    
    
    func fetchUpcomingLaunchs( completion: @escaping (Result<[LaunchDetail]>) -> Void) {
        let urlString = baseUrlString + "launches/upcoming"
        var request = URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
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
    
    func fetchAllLaunchs(page: Int, perPage: Int, completion: @escaping (Result<[LaunchDetail]>) -> Void) {
        let urlString = baseUrlString + "launches?limit=\(perPage)&offset=\((page-1)*perPage)"
        var request = URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        AF.request(request).responseData { response in
            let count = response.response?.headers["Spacex-Api-Count"]
            let tCount: Int = count == nil ? 0 : Int(count!)!
            
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let response = try decoder.decode([LaunchDetail].self, from: data)
                    completion(.success(response, tCount))
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
    func fetchLaunch(flightNumber: Int, completion: @escaping (Result<LaunchDetail>) -> Void) {
        let urlString = baseUrlString + "launches/" + String(flightNumber)
        var request = URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let response = try decoder.decode(LaunchDetail.self, from: data)
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
