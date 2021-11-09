//
//  LaunchDetailViewController.swift
//  FlightObserver
//
//  Created by Furkan Torun on 9.11.2021.
//

import Foundation
import UIKit
import Kingfisher

final class LaunchDetailViewController: UIViewController {
    
    var viewModel: LaunchDetailViewModelProtocol!
    var loading : UIView?

    let imgMissionPatch: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let lblMissionName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lblDetail: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblLaunchDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsVerticalScrollIndicator = false
        return v
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
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

extension LaunchDetailViewController: LaunchDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: LaunchDetailViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            showSpinner(isLoading: isLoading)
        }
    }
    
    func showDetail(_ presentation: LaunchDetail) {
        
        self.view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0).isActive = true

        scrollView.addSubview(imgMissionPatch)
        imgMissionPatch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        imgMissionPatch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        imgMissionPatch.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.0).isActive = true
        imgMissionPatch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true

        scrollView.addSubview(lblMissionName)
        lblMissionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        lblMissionName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        lblMissionName.topAnchor.constraint(equalTo: imgMissionPatch.bottomAnchor, constant: 16.0).isActive = true

        scrollView.addSubview(lblDetail)
        lblDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        lblDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        lblDetail.topAnchor.constraint(equalTo: lblMissionName.bottomAnchor, constant: 16).isActive = true
        lblDetail.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        
        self.view.addSubview(lblLaunchDate)
        lblLaunchDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        lblLaunchDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        lblLaunchDate.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        lblLaunchDate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true

        let url = URL(string: presentation.links.mission_patch!)
        imgMissionPatch.kf.setImage(with: url)
        lblMissionName.text = presentation.missionName
        lblDetail.text = presentation.details
        lblLaunchDate.text = presentation.launchDateFormatted
    }
    

    

}
