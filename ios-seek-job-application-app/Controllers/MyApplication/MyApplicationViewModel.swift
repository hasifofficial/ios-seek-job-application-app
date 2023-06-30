//
//  MyApplicationViewModel.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine

class MyApplicationViewModel {
    let service: JobServiceable
    
    var pageDetailSubject = CurrentValueSubject<JobResponse?, Never>(nil)
    var appliedJobsSubject = CurrentValueSubject<[Job], Never>([])
    var currentPageSubject = CurrentValueSubject<Int, Never>(1)
    var errorSubject = PassthroughSubject<Error, Never>()

    private var cancellable = Set<AnyCancellable>()
    
    init(service: JobServiceable) {
        self.service = service
        
        loadAppliedJobListing()
    }
    
    func loadAppliedJobListing(page: Int = 1) {
        service.getAppliedJobs(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorSubject.send(error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.appliedJobsSubject.send(response.jobs)
            }
            .store(in: &cancellable)
    }
}
