//
//  JobDetailViewModel.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine

class JobDetailViewModel {
    let id: String
    let service: JobServiceable
    
    var jobDetailSubject = CurrentValueSubject<Job?, Never>(nil)
    var applyJobSuccessSubject = PassthroughSubject<Void, Never>()
    var errorSubject = PassthroughSubject<Error, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(
        id: String,
        service: JobServiceable
    ) {
        self.id = id
        self.service = service
        
        loadJobDetail()
    }
    
    func loadJobDetail() {
        service.getJobDetail(id: id)
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
                
                self.jobDetailSubject.send(response)
            }
            .store(in: &cancellable)
    }
    
    func applyJob() {
        service.applyJob(jobId: id)
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
                
                self.applyJobSuccessSubject.send(())
            }
            .store(in: &cancellable)
    }
}
