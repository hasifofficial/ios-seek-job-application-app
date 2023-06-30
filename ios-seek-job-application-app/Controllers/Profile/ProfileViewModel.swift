//
//  ProfileViewModel.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine

class ProfileViewModel {
    var logoutSuccessSubject = PassthroughSubject<Void, Never>()

    func logout() {
        // Clear all session, cache, keychain here
        logoutSuccessSubject.send(())
    }
}
