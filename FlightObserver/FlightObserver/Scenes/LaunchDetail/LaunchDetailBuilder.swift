//
//  LaunchDetailBuilder.swift
//  FlightObserver
//
//  Created by Furkan Torun on 9.11.2021.
//

import UIKit

final class LaunchDetailBuilder {
    
    static func make(with viewModel: LaunchDetailViewModelProtocol) -> LaunchDetailViewController {
        let storyboard = UIStoryboard(name: "LaunchDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LaunchDetailViewController") as! LaunchDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
}
