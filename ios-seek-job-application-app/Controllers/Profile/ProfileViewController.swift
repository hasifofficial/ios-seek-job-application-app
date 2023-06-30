//
//  ProfileViewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit
import Combine

class ProfileViewController: UIViewController {
    private let logoutButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle(NSLocalizedString("profile_logout_button", comment: ""), for: .normal)
        newButton.setTitleColor(.textReversed, for: .normal)
        newButton.titleLabel?.font = .button
        newButton.backgroundColor = .button
        newButton.translatesAutoresizingMaskIntoConstraints = false
        return newButton
    }()
    
    private var cancellable = Set<AnyCancellable>()
    
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }

    private func setupViews() {
        title = NSLocalizedString("profile_title", comment: "")
        
        view.backgroundColor = .backgroundSecondary
        view.addSubview(logoutButton)
        
        logoutButton.layer.cornerRadius = 5.0
        
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            logoutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupListener() {
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        
        viewModel.logoutSuccessSubject
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.navigateToRoot()
            }
            .store(in: &cancellable)
    }
    
    private func setupNavBar() {
        setupThemeNavBar()
    }
    
    private func navigateToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func logoutButtonAction() {
        viewModel.logout()
    }
}
