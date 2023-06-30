//
//  JobServiceMockable.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine
@testable import ios_seek_job_application_app

final class JobServiceMock: Mockable, JobServiceable {
    var isFetchGetJobsCalled = false
    var isFetchGetPublishedJobsCalled = false
    var isFetchGetAppliedJobsCalled = false
    var isFetchGetJobDetailCalled = false
    var isFetchPutApplyJobCalled = false

    func getJobs(page: Int) -> Future<JobResponse, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            self.isFetchGetJobsCalled = true
            promise(.success(self.loadJSON(filename: "get_jobs_response", type: JobResponse.self)))
        }
    }
    
    func getPublishedJobs(page: Int) -> Future<JobResponse, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            self.isFetchGetPublishedJobsCalled = true
            promise(.success(self.loadJSON(filename: "get_published_jobs_response", type: JobResponse.self)))
        }
    }
    
    func getAppliedJobs(page: Int) -> Future<JobResponse, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            self.isFetchGetAppliedJobsCalled = true
            promise(.success(self.loadJSON(filename: "get_applied_jobs_response", type: JobResponse.self)))
        }
    }
    
    func getJobDetail(id: String) -> Future<Job, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            self.isFetchGetJobDetailCalled = true
            promise(.success(self.loadJSON(filename: "get_job_detail_response", type: Job.self)))
        }
    }
    
    func applyJob(jobId: String) -> Future<ApplyJobResponse, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            self.isFetchPutApplyJobCalled = true
            promise(.success(self.loadJSON(filename: "put_apply_job_response", type: ApplyJobResponse.self)))
        }
    }
}
