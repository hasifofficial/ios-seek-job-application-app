//
//  LoginViewModel.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine

class LoginViewModel {
    var usernameSubject = CurrentValueSubject<String?, Never>("")
    var passwordSubject = CurrentValueSubject<String?, Never>("")
    var isFormValidSubject = CurrentValueSubject<Bool, Never>(false)
    var loginSuccessSubject = PassthroughSubject<Void, Never>()
    var errorSubject = PassthroughSubject<Error, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    func login() {
        guard let username = usernameSubject.value,
              let password = passwordSubject.value else { return }
        
        // Call login api here

        #if DEBUG
        print("username: \(username)")
        print("password: \(password)")
        #endif
        
        loginSuccessSubject.send(())
    }
    
    func checkLoginFormValidity() {
        isFormValidSubject.send(usernameSubject.value != "" && passwordSubject.value != "")
    }
    
    func setUsername(_ username: String?) {
        usernameSubject.send(username)
        
        checkLoginFormValidity()
    }
    
    func setPassword(_ password: String?) {
        passwordSubject.send(password)
        
        checkLoginFormValidity()
    }
}
