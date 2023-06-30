//
//  JobService.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Combine

protocol JobServiceable {
    func getJobs(page: Int) -> Future<JobResponse, Error>
    func getPublishedJobs(page: Int) -> Future<JobResponse, Error>
    func getAppliedJobs(page: Int) -> Future<JobResponse, Error>
    func getJobDetail(id: String)  -> Future<Job, Error>
    func applyJob(jobId: String) -> Future<ApplyJobResponse, Error>
}

struct JobService: JobServiceable {
    func getJobs(page: Int) -> Future<JobResponse, Error> {
        API.shared.request(
            endpoint: JobEndpoints.getJobs(page: page),
            type: JobResponse.self
        )
    }

    func getPublishedJobs(page: Int)  -> Future<JobResponse, Error> {
        API.shared.request(
            endpoint: JobEndpoints.getPublishedJobs(page: page),
            type: JobResponse.self
        )
    }
    
    func getAppliedJobs(page: Int) -> Future<JobResponse, Error> {
        API.shared.request(
            endpoint: JobEndpoints.getAppliedJobs(page: page),
            type: JobResponse.self
        )
    }
    
    func getJobDetail(id: String)  -> Future<Job, Error> {
        API.shared.request(
            endpoint: JobEndpoints.getJobDetail(id: id),
            type: Job.self
        )
    }
    
    func applyJob(jobId: String) -> Future<ApplyJobResponse, Error> {
        API.shared.request(
            endpoint: JobEndpoints.applyJob(jobId: jobId),
            type: ApplyJobResponse.self
        )
    }
}
