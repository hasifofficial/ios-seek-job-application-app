//
//  JobListingViewModelTests.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import XCTest
@testable import ios_seek_job_application_app

final class JobListingViewModelTests: XCTestCase {
    let mockService = JobServiceMock()
    lazy var sut = JobListingViewModel(service: mockService)
        
    override class func setUp() {
        super.setUp()
    }
        
    func testFetchGetJobs() {
        sut.loadJobListing()

        XCTAssertTrue(mockService.isFetchGetPublishedJobsCalled)
    }
}
