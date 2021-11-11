//
//  LaunchListBuilder.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import UIKit

final class LaunchListBuilder {

    static func make() -> LaunchListViewController {
        let storyboard = UIStoryboard(name: "LaunchList", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LaunchListViewController") as! LaunchListViewController
        viewController.viewModel = LaunchListViewModel(service: app.service)
        return viewController
    }
    
}
