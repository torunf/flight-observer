//
//  LaunchListViewModel.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//


import Foundation
import UIKit
import Kingfisher

final class LaunchListViewModel: NSObject, LaunchListViewModelProtocol {
    
    
    weak var delegate: LaunchListViewModelDelegate?
    private let service: LaunchApiServiceProtocol
    private var upcomingLaunchs: [LaunchDetail]? = nil
    private var allLaunchs: [LaunchDetail]? = nil

    init(service: LaunchApiServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("LAUNCHES"))
        notify(.setLoading(true))
        self.getSlider()
        self.getList()
    }
    
    func getSlider() {
        service.fetchUpcomingLaunchs() { [weak self](result) in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                self?.upcomingLaunchs = response
                self?.notify(.showSliders(true))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getList() {
        service.fetchAllLaunchs() { [weak self](result) in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                self?.allLaunchs = response
                self?.notify(.showLaunchList(true))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func notify(_ output: LaunchListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

extension LaunchListViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allLaunchs != nil {
            return allLaunchs!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? FlightDetailRow {
            
            print(indexPath.row)
            print(indexPath.section)

            let item = allLaunchs![indexPath.row]
            cell.lblFlightHeader?.text = item.mission_name
            cell.lblFlightDate?.text = item.launchDateFormatted
            if item.links.mission_patch_small != nil {
                let url = URL(string: item.links.mission_patch_small!)
                cell.imgFlight!.kf.setImage(with: url)
            }
            if item.details != nil {
                cell.lblFlightDetail?.text = item.details
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
