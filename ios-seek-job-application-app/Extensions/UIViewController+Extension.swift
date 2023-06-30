//
//  UIViewController+Extension.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setupThemeNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textReversed]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = .backgroundBrand
        navigationController?.navigationBar.tintColor = .textReversed
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .backgroundBrand
        navigationController?.view.backgroundColor = .backgroundBrand
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
