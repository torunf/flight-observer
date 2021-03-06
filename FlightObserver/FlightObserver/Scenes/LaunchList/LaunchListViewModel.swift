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
    private var upcomingLaunchs: [LaunchDetail]? = []
    private var allLaunchs: [LaunchDetail]? = []
    private var launchsTotalCount: Int = 0
    private var page = 1
    private var perPage = 8
    var fetchingMore: Bool = true
    var totalPage: Int {
        if launchsTotalCount == 0 {
            return 0
        }
        return (launchsTotalCount / perPage) + 1
    }
    
    init(service: LaunchApiServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("SpaceX LAUNCHES"))
        self.getSlider()
    }
    
    func getSlider() {
        notify(.setLoading(true, .slider))
        service.fetchUpcomingLaunchs() { [weak self](result) in
            guard self != nil else { return }
            switch result {
            case .success(let response, _):
                self?.upcomingLaunchs = response
                let x:[InputSource] = response.map { KingfisherSource(urlString: $0.links.mission_patch ?? "https://pic.onlinewebfonts.com/svg/img_546302.png" )! }
                self?.notify(.showSliders(x))
                self?.notify(.setLoading(false, .slider))
                self?.getList()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getList() {
        self.fetchingMore = false
        notify(.setLoading(true, .list))
        service.fetchAllLaunchs(page: self.page, perPage: self.perPage) { [weak self](result) in
            guard self != nil else { return }
            switch result {
            case .success(let response, let count):
                self?.allLaunchs?.append(contentsOf: response)
                self?.launchsTotalCount = count
                if self!.page < self!.totalPage {
                    self!.page += 1
                    self!.fetchingMore = true
                }
                self?.notify(.showLaunchList(true))
                self?.notify(.setLoading(false, .list))
            case .failure(let error):
                print(error)
            }
        }
    }

    func getDetail(withIndex ix: Int) {
        let item = self.allLaunchs![ix]
        service.fetchLaunch(flightNumber: item.flightNumber) { [weak self](result) in
            guard self != nil else { return }
            switch result {
            case .success(let response, _):
                let viewModel = LaunchDetailViewModel(launchDetail: response)
                self!.delegate?.navigate(to: .detail(viewModel))
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
            let item = allLaunchs![indexPath.row]
            cell.lblFlightHeader?.text = item.missionName
            cell.lblFlightDate?.text = item.launchDateFormatted
            
            let url: URL?
            if item.links.mission_patch_small != nil {
                url = URL(string: item.links.mission_patch_small!)
            }
            else {
                url = URL(string: "https://pic.onlinewebfonts.com/svg/img_546302.png")
            }
            cell.imgFlight!.kf.indicatorType = .activity
            cell.imgFlight!.kf.setImage(with: url)
            cell.lblFlightDetail?.text = item.details ?? ""
            
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
