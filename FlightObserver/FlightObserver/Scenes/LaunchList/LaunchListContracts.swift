//
//  LaunchListContracts.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation
import ImageSlideshow

protocol LaunchListViewModelProtocol {
    var delegate: LaunchListViewModelDelegate? { get set }
    func load()
    func getSlider()
    func getList()
}

enum LaunchListViewModelOutput: Equatable {
    static func == (lhs: LaunchListViewModelOutput, rhs: LaunchListViewModelOutput) -> Bool {
        return true
    }
    
    case updateTitle(String)
    case setLoading(Bool)
    case showSliders([InputSource])
    case showLaunchList(Bool)
}

enum LaunchListViewRoute {
//    case detail(LaunchDetailViewModelProtocol)
}

protocol LaunchListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LaunchListViewModelOutput)
}
