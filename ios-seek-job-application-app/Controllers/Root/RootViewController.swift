//
//  RootViewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vm = LoginViewModel()
            let vc = LoginViewController(viewModel: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .backgroundSecondary
    }
    
    private func setupNavBar() {
        setupThemeNavBar()
    }
}
