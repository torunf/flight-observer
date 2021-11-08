//
//  LaunchListViewController.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation
import UIKit

final class LaunchListViewController: UIViewController {
    var viewModel: LaunchListViewModelProtocol!
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        
        tableView?.dataSource = viewModel as! UITableViewDataSource
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
        case .showSliders(_):
//            self.viewModel.getSlider()
            break
        case .showLaunchList(_):
            self.tableView?.reloadData()
            break
        }
    }    
}
//
//extension LaunchListViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.viewModel.
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items[section].rowCount
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = items[indexPath.section]
//        switch item.type {
//        case .nameAndPicture:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: NamePictureCell.identifier, for: indexPath) as? NamePictureCell {
//                cell.item = item
//                return cell
//            }
//        case .about:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
//                cell.item = item
//                return cell
//            }
//        case .email:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.identifier, for: indexPath) as? EmailCell {
//                cell.item = item
//                return cell
//            }
//        case .friend:
//            if let item = item as? ProfileViewModeFriendsItem, let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell {
//                let friend = item.friends[indexPath.row]
//                cell.item = friend
//                return cell
//            }
//        case .attribute:
//            if let item = item as? ProfileViewModeAttributeItem, let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: indexPath) as? AttributeCell {
//                cell.item = item.attributes[indexPath.row]
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return items[section].sectionTitle
//    }
//
//}
