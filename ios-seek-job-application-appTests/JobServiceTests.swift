//
//  JobServiceTests.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import XCTest
import Combine
@testable import ios_seek_job_application_app

final class JobServiceTests: XCTestCase {
    private var cancellable = Set<AnyCancellable>()
    let sut = JobServiceMock()
    
    override class func setUp() {
        super.setUp()
    }
        
    func testGetJobsMock() {
        let result = sut.getJobs(page: 1)
            
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The request should not fail")
                }
            } receiveValue: { response in
                XCTAssertNotNil(response.jobs)
            }
            .store(in: &cancellable)
    }
    
    func testGetPublishedJobsMock() {
        let result = sut.getPublishedJobs(page: 1)
            
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The request should not fail")
                }
            } receiveValue: { response in
                for job in response.jobs {
                    XCTAssertEqual(job.status, JobStatus.published)
                }
            }
            .store(in: &cancellable)
    }
    
    func testGetAppliedJobsMock() {
        let result = sut.getAppliedJobs(page: 1)
            
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The request should not fail")
                }
            } receiveValue: { response in
                for job in response.jobs {
                    XCTAssertTrue(job.haveIApplied)
                }
            }
            .store(in: &cancellable)
    }

    
    func testGetJobDetailMock() {
        let result = sut.getJobDetail(id: "job-6")
            
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The request should not fail")
                }
            } receiveValue: { response in
                XCTAssertEqual(response.location, JobLocation.Malaysia)
                XCTAssertEqual(response.status, JobStatus.published)
                XCTAssertEqual(response.industry, JobIndustry.Technology)
            }
            .store(in: &cancellable)
    }
    
    func testApplyJobMock() {
        let result = sut.applyJob(jobId: "job-6")
            
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The request should not fail")
                }
            } receiveValue: { response in
                XCTAssertEqual(response.status, ApplicationStatus.received)
            }
            .store(in: &cancellable)
    }
}
