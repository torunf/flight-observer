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
    var loading : UIView?

    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        
        tableView?.dataSource = viewModel as? UITableViewDataSource
        tableView?.estimatedRowHeight = 100
    }
    
    public func showSpinner(isLoading: Bool) {
        if(!isLoading) {
            removeSpinner()
            return
        }
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = view.center
             
        DispatchQueue.main.async {
            self.view.addSubview(ai)
        }
        loading = ai
    }
    
    public func removeSpinner() {
        DispatchQueue.main.async {
            self.loading?.removeFromSuperview()
            self.loading = nil
        }
    }
}


extension LaunchListViewController: LaunchListViewModelDelegate {
    
    func handleViewModelOutput(_ output: LaunchListViewModelOutput) {
        
        switch output {
        case .updateTitle(let title):
            self.title = title
            break
        case .setLoading(let isLoading):
            showSpinner(isLoading: isLoading)
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
        let item = self.viewModel.getLaunch(withIndex: indexPath.row)
        let viewModel = LaunchDetailViewModel(launchDetail: item)
        self.viewModel!.delegate!.navigate(to: .detail(viewModel))        
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
