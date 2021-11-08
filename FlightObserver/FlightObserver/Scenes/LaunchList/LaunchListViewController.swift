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
    
}


extension LaunchListViewController: LaunchListViewModelDelegate {
    
    func handleViewModelOutput(_ output: LaunchListViewModelOutput) {
        
        switch output {
        case .updateTitle(let title):
            self.title = title
            break
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            break
        case .showSliders(let slides):
            
            
            
//            let x:[InputSource] = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!]
            
            slideshow.setImageInputs(slides)
            
            
            break
        case .showLaunchList(_):
            self.tableView?.reloadData()
            break
        }
    }    
}
