//
//  HomeTabBarVIewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

class HomeTabBarVIewController: UITabBarController {
    let jobService: JobServiceable
    
    init(
        jobService: JobServiceable
    ) {
        self.jobService = jobService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }

    private func setupViews() {
        delegate = self
        
        tabBar.barTintColor = .cardBackground
        tabBar.tintColor = .backgroundBrand
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            makeJobListingViewController(),
            makeMyApplicationViewController()
        ]

        title = viewControllers?.first?.title
    }
    
    private func setupNavBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func makeJobListingViewController() -> JobListingViewController {
        let vm = JobListingViewModel(service: jobService)
        let vc = JobListingViewController(viewModel: vm)
        let tabBarItem = UITabBarItem(
            title: NSLocalizedString("job_listing_title", comment: ""),
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private func makeMyApplicationViewController() -> MyApplicationViewController {
        let vm = MyApplicationViewModel(service: jobService)
        let vc = MyApplicationViewController(viewModel: vm)
        let tabBarItem = UITabBarItem(
            title: NSLocalizedString("my_application_title", comment: ""),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star")
        )
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        vc.tabBarItem = tabBarItem
        return vc
    }
}

extension HomeTabBarVIewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        title = viewController.title
    }
}
