//
//  JobResponse.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation

struct JobResponse: Codable {
    let page: Int
    let size: Int
    let total: Int
    let hasNext: Bool
    let jobs: [Job]
}

struct Job: Codable {
    let id: String
    let positionTitle: String
    let description: String
    let company: Company
    let salaryRange: Salary
    let location: JobLocation
    let status: JobStatus
    let industry: JobIndustry
    let createdAt: String
    let updatedAt: String
    let haveIApplied: Bool
}

struct Company: Codable {
    let id: String
    let name: String
}

struct Salary: Codable {
    let min: Int
    let max: Int
}

enum JobLocation: String, Codable {
    case Australia
    case Malaysia
    case Singapore
    case Indonesia
}

enum JobStatus: String, Codable {
    case draft = "DRAFT"
    case published = "PUBLISHED"
    case expired = "EXPIRED"
    case banned = "BANNED"
}

enum JobIndustry: String, Codable {
    case Technology
    case Marketing
    case HR
}
