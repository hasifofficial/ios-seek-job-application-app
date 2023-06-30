//
//  UIFont+Extension.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

extension UIFont {
    static var headline6: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    static var headline7: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    static var body2: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static var caption: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static var button: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
