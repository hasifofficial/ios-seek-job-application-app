//
//  ApplyJobResponse.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation

struct ApplyJobResponse: Codable {
    let userId: String
    let jobId: String
    let status: ApplicationStatus
}

enum ApplicationStatus: String, Codable {
    case received = "RECEIVED"
    case inReview = "IN_REVIEW"
    case shortlisted = "SHORTLISTED"
    case invited = "INVITED"
    case hired = "HIRED"
    case regretted = "REGRETTED"
}
