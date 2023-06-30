//
//  JobDescriptionTableViewCell.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

class JobDescriptionTableViewCell: UITableViewCell {
    private let expiredIndicatorView: UIView = {
        let newView = UIView()
        newView.backgroundColor = .textSecondary
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    private let expiredIndicatorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.text = NSLocalizedString("job_listing_expired", comment: "")
        newLabel.font = .caption
        newLabel.textColor = .textReversed
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()

    private let jobTitleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .headline7
        newLabel.textColor = .textPrimary
        newLabel.numberOfLines = 0
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let companyNameLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = .caption
        newLabel.textColor = .textSecondary
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
    
    private let appliedIndicatorView: UIView = {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    private let appliedIndicatorIcon: UIImageView = {
        let newImageView = UIImageView()
        newImageView.image = UIImage(named: "ico_tick")
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        return newImageView
    }()

    private let appliedIndicatorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.text = NSLocalizedString("job_listing_applied", comment: "")
        newLabel.font = .caption
        newLabel.textColor = .textSecondary
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()

    private let containerView: UIView = {
        let newView = UIView()
        newView.backgroundColor = .cardBackground
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    var viewModel: JobDescriptionTableViewCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        
        backgroundColor = .backgroundSecondary
        expiredIndicatorView.addSubview(expiredIndicatorLabel)
        
        appliedIndicatorView.addSubview(appliedIndicatorIcon)
        appliedIndicatorView.addSubview(appliedIndicatorLabel)

        containerView.addSubview(expiredIndicatorView)
        containerView.addSubview(jobTitleLabel)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(jobDescriptionLabel)
        containerView.addSubview(appliedIndicatorView)

        expiredIndicatorView.layer.cornerRadius = 5.0
        containerView.layer.cornerRadius = 5.0

        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            expiredIndicatorLabel.topAnchor.constraint(equalTo: expiredIndicatorView.topAnchor, constant: 4.0),
            expiredIndicatorLabel.bottomAnchor.constraint(equalTo: expiredIndicatorView.bottomAnchor, constant: -4.0),
            expiredIndicatorLabel.leadingAnchor.constraint(equalTo: expiredIndicatorView.leadingAnchor, constant: 4.0),
            expiredIndicatorLabel.trailingAnchor.constraint(equalTo: expiredIndicatorView.trailingAnchor, constant: -4.0),

            expiredIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
            expiredIndicatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.0),

            jobTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.0),
            jobTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16.0),
            jobTitleLabel.topAnchor.constraint(equalTo: expiredIndicatorView.bottomAnchor, constant: 16.0),
            
            companyNameLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            companyNameLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 4.0),
            
            jobDescriptionLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            jobDescriptionLabel.trailingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor),
            jobDescriptionLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 16.0),
            
            appliedIndicatorView.leadingAnchor.constraint(equalTo: jobTitleLabel.leadingAnchor),
            appliedIndicatorView.topAnchor.constraint(equalTo: jobDescriptionLabel.bottomAnchor, constant: 16.0),
            appliedIndicatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0),

            appliedIndicatorIcon.heightAnchor.constraint(equalToConstant: 25.0),
            appliedIndicatorIcon.widthAnchor.constraint(equalToConstant: 25.0),
            appliedIndicatorIcon.topAnchor.constraint(equalTo: appliedIndicatorView.topAnchor),
            appliedIndicatorIcon.bottomAnchor.constraint(equalTo: appliedIndicatorView.bottomAnchor),
            appliedIndicatorIcon.leadingAnchor.constraint(equalTo: appliedIndicatorView.leadingAnchor),
            
            appliedIndicatorLabel.leadingAnchor.constraint(equalTo: appliedIndicatorIcon.trailingAnchor, constant: 8.0),
            appliedIndicatorLabel.centerYAnchor.constraint(equalTo: appliedIndicatorIcon.centerYAnchor),

            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with model: JobDescriptionTableViewCellViewModel) {
        jobTitleLabel.text = model.jobTitle
        companyNameLabel.text = model.companyName
        jobDescriptionLabel.text = model.jobDescriptionLabel
        expiredIndicatorView.isHidden = model.jobStatus != .expired
        appliedIndicatorView.isHidden = !model.haveIApplied
        
        if model.jobStatus != .expired {
            jobTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0).isActive = true
        } else {
            jobTitleLabel.topAnchor.constraint(equalTo: expiredIndicatorView.bottomAnchor, constant: 16.0).isActive = true
        }
        
        if !model.haveIApplied {
            jobDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0).isActive = true
        } else {
            jobDescriptionLabel.bottomAnchor.constraint(equalTo: appliedIndicatorView.topAnchor, constant: -16.0).isActive = true
            appliedIndicatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0).isActive = true
        }
        
        viewModel = model
    }
}

struct JobDescriptionTableViewCellViewModel {
    let jobId: String
    let jobTitle: String
    let companyName: String
    let jobDescriptionLabel: String
    let jobStatus: JobStatus
    let haveIApplied: Bool
}
