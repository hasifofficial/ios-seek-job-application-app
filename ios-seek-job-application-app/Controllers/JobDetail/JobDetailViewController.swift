//
//  JobDetailViewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit
import Combine

class JobDetailViewController: UIViewController {
    private let jobTitleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .headline6
        newLabel.textColor = .textPrimary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let companyNameLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .headline7
        newLabel.textColor = .textPrimary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let locationLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .body2
        newLabel.textColor = .textSecondary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let industryLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .body2
        newLabel.textColor = .textSecondary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let salaryLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .body2
        newLabel.textColor = .textSecondary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let jobDescriptionTitleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.text = NSLocalizedString("job_detail_description_title", comment: "")
        newLabel.font = .body2
        newLabel.textColor = .textPrimary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()

    private let jobDescriptionLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .body2
        newLabel.textColor = .textPrimary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let containerScrollView: UIScrollView = {
        let newScrollView = UIScrollView()
        newScrollView.translatesAutoresizingMaskIntoConstraints = false
        return newScrollView
    }()

    private var applyButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle(NSLocalizedString("job_detail_apply_button", comment: ""), for: .normal)
        newButton.setTitleColor(.textReversed, for: .normal)
        newButton.titleLabel?.font = .button
        newButton.backgroundColor = .button
        newButton.translatesAutoresizingMaskIntoConstraints = false
        return newButton
    }()

    private var cancellable = Set<AnyCancellable>()

    let viewModel: JobDetailViewModel
    
    init(viewModel: JobDetailViewModel) {
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
        view.backgroundColor = .white
        
        containerScrollView.addSubview(jobTitleLabel)
        containerScrollView.addSubview(companyNameLabel)
        containerScrollView.addSubview(locationLabel)
        containerScrollView.addSubview(industryLabel)
        containerScrollView.addSubview(salaryLabel)
        containerScrollView.addSubview(jobDescriptionTitleLabel)
        containerScrollView.addSubview(jobDescriptionLabel)
        
        view.addSubview(containerScrollView)
        view.addSubview(applyButton)

        applyButton.layer.cornerRadius = 5.0
        
        NSLayoutConstraint.activate([
            jobTitleLabel.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 16.0),
            jobTitleLabel.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16.0),
            jobTitleLabel.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16.0),

            companyNameLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 8.0),
            companyNameLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            companyNameLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),

            locationLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 24.0),
            locationLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),

            industryLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8.0),
            industryLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            industryLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),

            industryLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8.0),
            industryLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            industryLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),

            salaryLabel.topAnchor.constraint(equalTo: industryLabel.bottomAnchor, constant: 8.0),
            salaryLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),
            
            jobDescriptionTitleLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 24.0),
            jobDescriptionTitleLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            jobDescriptionTitleLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),
            
            jobDescriptionLabel.topAnchor.constraint(equalTo: jobDescriptionTitleLabel.bottomAnchor, constant: 8.0),
            jobDescriptionLabel.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor, constant: -16.0),
            jobDescriptionLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            jobDescriptionLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),
            
            containerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerScrollView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            applyButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupListener() {
        applyButton.addTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
        
        viewModel.jobDetailSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] job in
                guard let self = self else { return }
                
                self.title = job?.positionTitle
                self.jobTitleLabel.text = job?.positionTitle
                self.companyNameLabel.text = job?.company.name
                self.locationLabel.text = job?.location.rawValue.capitalized
                self.industryLabel.text = job?.industry.rawValue.capitalized
                self.salaryLabel.text = "$\(job?.salaryRange.min ?? 0) - $\(job?.salaryRange.max ?? 0)"
                self.jobDescriptionLabel.text = job?.description
            }
            .store(in: &cancellable)
        
        viewModel.applyJobSuccessSubject
            .sink { [weak self] error in
                guard let self = self else { return }
                
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellable)

        viewModel.errorSubject
            .sink { [weak self] error in
                guard self != nil else { return }
                
                print(error.localizedDescription)
            }
            .store(in: &cancellable)
    }
    
    private func setupNavBar() {
        setupThemeNavBar()
    }
    
    @objc private func applyButtonAction() {
        viewModel.applyJob()
    }
}
