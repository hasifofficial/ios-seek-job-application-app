//
//  LoginVIewController.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit
import Combine

class LoginViewController: UIViewController {
    private let usernameLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.text = NSLocalizedString("login_username_title", comment: "")
        newLabel.font = .button
        newLabel.textColor = .textPrimary
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let usernameBorderView: UIView = {
        let newView = UIView()
        newView.backgroundColor = .textSecondary
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    private lazy var usernameTextfield: UITextField = {
        let newTextField = UITextField()
        newTextField.textColor = .textPrimary
        newTextField.tintColor = .backgroundBrand
        newTextField.backgroundColor = .cardBackground
        newTextField.borderStyle = .none
        newTextField.delegate = self
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    private let usernameErrorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textColor = .red
        newLabel.font = .caption
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let usernameStackView: UIStackView = {
        let newStackView = UIStackView()
        newStackView.axis = .vertical
        newStackView.spacing = 8
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        return newStackView
    }()
    
    private let passwordLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.text = NSLocalizedString("login_password_title", comment: "")
        newLabel.font = .button
        newLabel.textColor = .textPrimary
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let passwordBorderView: UIView = {
        let newView = UIView()
        newView.backgroundColor = .textSecondary
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    private lazy var passwordTextfield: UITextField = {
        let newTextField = UITextField()
        newTextField.textColor = .textPrimary
        newTextField.tintColor = .backgroundBrand
        newTextField.backgroundColor = .cardBackground
        newTextField.borderStyle = .none
        newTextField.isSecureTextEntry = true
        newTextField.delegate = self
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    private let passwordErrorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textColor = .red
        newLabel.font = .caption
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    private let passwordStackView: UIStackView = {
        let newStackView = UIStackView()
        newStackView.axis = .vertical
        newStackView.spacing = 8
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        return newStackView
    }()
    
    private let loginButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle(NSLocalizedString("login_button", comment: ""), for: .normal)
        newButton.setTitleColor(.textReversed, for: .normal)
        newButton.titleLabel?.font = .button
        newButton.backgroundColor = .textSecondary
        newButton.isEnabled = false
        newButton.translatesAutoresizingMaskIntoConstraints = false
        return newButton
    }()
    
    private var cancellable = Set<AnyCancellable>()

    let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }

    private func setupViews() {
        title = NSLocalizedString("login_title", comment: "")
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .cardBackground
        
        usernameBorderView.addSubview(usernameTextfield)
        
        usernameStackView.addArrangedSubview(usernameLabel)
        usernameStackView.addArrangedSubview(usernameBorderView)
        usernameStackView.addArrangedSubview(usernameErrorLabel)
        
        passwordBorderView.addSubview(passwordTextfield)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordBorderView)
        passwordStackView.addArrangedSubview(passwordErrorLabel)

        view.addSubview(usernameStackView)
        view.addSubview(passwordStackView)
        view.addSubview(loginButton)

        usernameTextfield.layer.cornerRadius = 5.0
        usernameBorderView.layer.cornerRadius = 5.0
        passwordTextfield.layer.cornerRadius = 5.0
        passwordBorderView.layer.cornerRadius = 5.0
        loginButton.layer.cornerRadius = 5.0
        
        usernameErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true

        NSLayoutConstraint.activate([
            usernameTextfield.heightAnchor.constraint(equalToConstant: 40.0),
            usernameTextfield.topAnchor.constraint(equalTo: usernameBorderView.topAnchor, constant: 1.0),
            usernameTextfield.bottomAnchor.constraint(equalTo: usernameBorderView.bottomAnchor, constant: -1.0),
            usernameTextfield.leadingAnchor.constraint(equalTo: usernameBorderView.leadingAnchor, constant: 1.0),
            usernameTextfield.trailingAnchor.constraint(equalTo: usernameBorderView.trailingAnchor, constant: -1.0),

            usernameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            usernameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            usernameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            passwordTextfield.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTextfield.topAnchor.constraint(equalTo: passwordBorderView.topAnchor, constant: 1.0),
            passwordTextfield.bottomAnchor.constraint(equalTo: passwordBorderView.bottomAnchor, constant: -1.0),
            passwordTextfield.leadingAnchor.constraint(equalTo: passwordBorderView.leadingAnchor, constant: 1.0),
            passwordTextfield.trailingAnchor.constraint(equalTo: passwordBorderView.trailingAnchor, constant: -1.0),

            passwordStackView.topAnchor.constraint(equalTo: usernameStackView.bottomAnchor, constant: 16.0),
            passwordStackView.leadingAnchor.constraint(equalTo: usernameStackView.leadingAnchor),
            passwordStackView.trailingAnchor.constraint(equalTo: usernameStackView.trailingAnchor),

            loginButton.leadingAnchor.constraint(equalTo: usernameStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameStackView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupListener() {
        usernameTextfield.addTarget(self, action: #selector(usernameTextdieldDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(passwordTextdieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        viewModel.isFormValidSubject
            .sink { [weak self] isValid in
                guard let self = self else { return }
                
                self.loginButton.isEnabled = isValid
                self.loginButton.backgroundColor = isValid ? .button : .textSecondary
            }
            .store(in: &cancellable)

        viewModel.loginSuccessSubject
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.navigateToHome()
            }
            .store(in: &cancellable)
        
        viewModel.errorSubject
            .sink { [weak self] error in
                guard self != nil else { return }
                
                print(error.localizedDescription)
            }
            .store(in: &cancellable)
    }
    
    private func setupNavBar() {
        setupThemeNavBar()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func navigateToHome() {
        let service = JobService()
        let vm = JobListingViewModel(service: service)
        let vc = JobListingViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func loginButtonAction() {
        viewModel.login()
    }
}

extension LoginViewController: UITextFieldDelegate {
    @objc func usernameTextdieldDidChange(_ textField: UITextField) {
        viewModel.setUsername(textField.text)
    }
        
    @objc func passwordTextdieldDidChange(_ textField: UITextField) {
        viewModel.setPassword(textField.text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextfield {
            usernameBorderView.backgroundColor = .backgroundBrand
            usernameErrorLabel.isHidden = true
        } else if textField == passwordTextfield {
            passwordBorderView.backgroundColor = .backgroundBrand
            passwordErrorLabel.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextfield {
            usernameErrorLabel.isHidden = textField.text != ""
            
            if textField.text == "" {
                usernameBorderView.backgroundColor = .red
                usernameErrorLabel.text = NSLocalizedString("login_username_error", comment: "")
            } else {
                usernameBorderView.backgroundColor = .textSecondary
            }
        } else if textField == passwordTextfield {
            passwordErrorLabel.isHidden = textField.text != ""

            if textField.text == "" {
                passwordBorderView.backgroundColor = .red
                passwordErrorLabel.text = NSLocalizedString("login_password_error", comment: "")
            } else {
                passwordBorderView.backgroundColor = .textSecondary
            }
        }
    }
}
