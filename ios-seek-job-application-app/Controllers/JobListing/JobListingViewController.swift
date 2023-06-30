//
//  JobListingViewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit
import Combine

class JobListingViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let newTableView = UITableView(frame: .zero, style: .plain)
        newTableView.delegate = self
        newTableView.dataSource = self
        newTableView.prefetchDataSource = self
        newTableView.separatorStyle = .none
        newTableView.estimatedRowHeight = 100
        newTableView.backgroundColor = .backgroundSecondary
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        newTableView.register(
            JobDescriptionTableViewCell.self,
            forCellReuseIdentifier: String(describing: JobDescriptionTableViewCell.self)
        )
        return newTableView
    }()
    
    private var cancellable = Set<AnyCancellable>()

    let viewModel: JobListingViewModel
    var jobs = [Job]()

    init(viewModel: JobListingViewModel) {
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
        title = NSLocalizedString("job_listing_title", comment: "")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupListener() {
        viewModel.jobsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] jobs in
                guard let self = self else { return }
                
                self.jobs = jobs
                self.tableView.reloadData()
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
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func navigateToJobDetails(with jobId: String) {

    }
}

extension JobListingViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let pageDetail = viewModel.pageDetailSubject.value,
              let lastIndexPath = indexPaths.last else { return }
        
        let currentPage = pageDetail.page
        let totalPages = pageDetail.total

        guard lastIndexPath.row >= viewModel.jobsSubject.value.count - 1,
              currentPage < totalPages else { return }

        viewModel.currentPageSubject.send(currentPage + 1)
        viewModel.loadJobListing(page: viewModel.currentPageSubject.value)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JobDescriptionTableViewCell.self), for: indexPath) as? JobDescriptionTableViewCell {
            let vm = JobDescriptionTableViewCellViewModel(
                jobId: jobs[indexPath.row].id,
                jobTitle: jobs[indexPath.row].positionTitle,
                companyName: jobs[indexPath.row].company.name,
                jobDescriptionLabel: jobs[indexPath.row].description,
                jobStatus: jobs[indexPath.row].status,
                haveIApplied: jobs[indexPath.row].haveIApplied
            )
            cell.configure(with: vm)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToJobDetails(with: jobs[indexPath.row].id)
    }
}
