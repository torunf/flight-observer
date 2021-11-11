//
//  LaunchListViewController.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation
import UIKit
import Kingfisher
import ImageSlideshow

final class LaunchListViewController: UIViewController {
    
    var viewModel: LaunchListViewModelProtocol!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        
        tableView?.dataSource = viewModel as? UITableViewDataSource
        tableView?.estimatedRowHeight = 100

    }
    
    public func showSpinner(isLoading: Bool, operation: Operations) {
        
        if isLoading {
            DispatchQueue.main.async {
                switch operation {
                case .slider:
                    self.slideshow.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: UIColor.white.withAlphaComponent(0.1))
                case .list:
                    self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: UIColor.white.withAlphaComponent(0.1))
                }
            }
        }
        else {
            DispatchQueue.main.async {
                switch operation {
                case .slider:
                    self.slideshow.activityStopAnimating()
                case .list:
                    self.view.activityStopAnimating()
                }
            }
        }
    }
    
    public func removeSpinner() {

    }
}

extension LaunchListViewController: LaunchListViewModelDelegate {
    
    func handleViewModelOutput(_ output: LaunchListViewModelOutput) {
        
        switch output {
        case .updateTitle(let title):
            self.title = title
            break
        case .setLoading(let isLoading, let operation):
            showSpinner(isLoading: isLoading, operation: operation)
            break
        case .showSliders(let slides):
            slideshow.setImageInputs(slides)
            break
        case .showLaunchList(_):
            self.tableView?.reloadData()
            break
        }
    }
    
    func navigate(to route: LaunchListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = LaunchDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}

extension LaunchListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.getDetail(withIndex: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.height){
            if self.viewModel!.fetchingMore {
                print("API Calling")
                self.viewModel.getList()
                
            }
        }
    }
}
