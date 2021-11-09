//
//  LaunchDetailContracts.swift
//  FlightObserver
//
//  Created by Furkan Torun on 9.11.2021.
//

import Foundation

protocol LaunchDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LaunchDetailViewModelOutput)
    func showDetail(_ presentation: LaunchDetail)
}

enum LaunchDetailViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
}

protocol LaunchDetailViewModelProtocol {
    var delegate: LaunchDetailViewModelDelegate? { get set }
    func load()
}


