//
//  LaunchListViewModel.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//


import Foundation
import UIKit
import Kingfisher
import ImageSlideshow

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
                let x:[InputSource] = response.map { KingfisherSource(urlString: $0.links.mission_patch ?? "https://pic.onlinewebfonts.com/svg/img_546302.png" )! }
                self?.notify(.showSliders(x))
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
                self?.notify(.setLoading(false))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLaunch(withIndex ix: Int ) -> LaunchDetail {
        let item = allLaunchs![ix]
        return item
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
            let item = allLaunchs![indexPath.row]
            cell.lblFlightHeader?.text = item.missionName
            cell.lblFlightDate?.text = item.launchDateFormatted
            if item.links.mission_patch_small != nil {
                let url = URL(string: item.links.mission_patch_small!)
                cell.imgFlight!.kf.setImage(with: url)
            }
            else {
                cell.imgFlight!.image = nil
            }
            cell.lblFlightDetail?.text = item.details ?? ""
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


//extension LaunchListViewModel: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = allLaunchs![indexPath.row]
//
//        let viewModel = LaunchDetailViewModel(launchDetail: item)
//        self.delegate?.navigate(to: .detail(viewModel))
//    }
//
//}

