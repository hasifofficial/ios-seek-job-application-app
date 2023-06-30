//
//  LoginViewModelTests.swift
//  ios-seek-job-application-appTests
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import XCTest
@testable import ios_seek_job_application_app

final class LoginViewModelTests: XCTestCase {
    let sut = LoginViewModel()
        
    override class func setUp() {
        super.setUp()
    }
        
    func testLoginFormValid() {
        sut.setUsername("mock-username")
        sut.setPassword("mock-password")

        XCTAssertTrue(sut.isFormValidSubject.value)
    }
    
    func testLoginFormInvalidEmptyUsername() {
        sut.setUsername("")
        sut.setPassword("mock-password")

        XCTAssertFalse(sut.isFormValidSubject.value)
    }
    
    func testLoginFormInvalidEmptyPassword() {
        sut.setUsername("mock-username")
        sut.setPassword("")

        XCTAssertFalse(sut.isFormValidSubject.value)
    }
}
