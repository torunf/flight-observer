//
//  LaunchDetailViewModel.swift
//  FlightObserver
//
//  Created by Furkan Torun on 9.11.2021.
//

import Foundation

final class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    weak var delegate: LaunchDetailViewModelDelegate?
    private let presentation: LaunchDetail
    
    init(launchDetail: LaunchDetail) {
        self.presentation = launchDetail
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateTitle("\(self.presentation.missionName.uppercased()) DETAIL"))
        delegate?.showDetail(presentation)
    }
    
}
