//
//  JobDetailViewModelTests.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import XCTest
@testable import ios_seek_job_application_app

final class JobDetailViewModelTests: XCTestCase {
    let mockService = JobServiceMock()
    lazy var sut = JobDetailViewModel(id: "mock-id", service: mockService)
        
    override class func setUp() {
        super.setUp()
    }
        
    func testFetchGetJobs() {
        sut.loadJobDetail()

        XCTAssertTrue(mockService.isFetchGetJobDetailCalled)
    }
    
    func testApplyJobs() {
        sut.applyJob()
        
        XCTAssertTrue(mockService.isFetchPutApplyJobCalled)
    }
}
