//
//  MyApplicationViewModelTests.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import XCTest
@testable import ios_seek_job_application_app

final class MyApplicationViewModelTests: XCTestCase {
    let mockService = JobServiceMock()
    lazy var sut = MyApplicationViewModel(service: mockService)
        
    override class func setUp() {
        super.setUp()
    }
        
    func testFetchGetJobs() {
        sut.loadAppliedJobListing()

        XCTAssertTrue(mockService.isFetchGetAppliedJobsCalled)
    }
}
