//
//  JobEndpoints.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation

enum JobEndpoints {
    case getJobs(page: Int)
    case getPublishedJobs(page: Int)
    case getAppliedJobs(page: Int)
    case getJobDetail(id: String)
    case applyJob(jobId: String)
}

extension JobEndpoints: Endpoint {
    var path: String {
        switch self {
        case .getJobs(let page):
            return "/v3/5d699b9d-5616-48b5-aaa8-d99b93284adb/\(page)" // Mock endpoint
//            return "/jobs" // Original endpoint
        case .getPublishedJobs(let page):
            return "/v3/254115bd-c228-4ea7-88df-50161a8c46f9/\(page)" // Mock endpoint
//            return "/jobs/published" // Original endpoint
        case .getAppliedJobs(let page):
            return "/v3/c6c0fe7a-3852-4787-9a50-c08f39ac4bf5/\(page)" // Mock endpoint
//            return "/jobs/applied" // Original endpoint
        case .getJobDetail(let id):
            return "/v3/7cb5d9a4-7fe6-4f8d-bd7b-a1766253564e/\(id)" // Mock endpoint
//            return "/jobs/\(id)" // Original endpoint
        case .applyJob:
            return "/v3/f1d39e41-edd8-4a9c-90c6-03299359500c" // Mock endpoint
//            return "/application" // Original endpoint
        }
    }

    var method: RequestMethod {
        switch self {
        case .getJobs, .getPublishedJobs, .getAppliedJobs, .getJobDetail:
            return .get
        case .applyJob:
            return .put
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .getJobs, .getPublishedJobs, .getAppliedJobs, .getJobDetail, .applyJob:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getJobs, .getPublishedJobs, .getAppliedJobs, .getJobDetail:
            return nil
        case.applyJob(let jobId):
            // Retrieve userid here
            let userId = "user1"
            return [
                "userId": userId,
                "jobId": jobId
            ]
        }
    }
}
