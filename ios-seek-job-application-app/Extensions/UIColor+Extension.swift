//
//  UIColor+Extension.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import UIKit

extension UIColor {
    static var backgroundBrand: UIColor {
        return uiColor("#0D3880")
    }
    
    static var backgroundSecondary: UIColor {
        return uiColor("#EFF3FB")
    }

    static var cardBackground: UIColor {
        return uiColor("#FFFFFF")
    }

    static var textPrimary: UIColor {
        return uiColor("#333A49")
    }

    static var textSecondary: UIColor {
        return uiColor("#69768C")
    }

    static var textReversed: UIColor {
        return uiColor("#FFFFFF")
    }

    static var button: UIColor {
        return uiColor("#2765CF")
    }
    
    static func uiColor(_ hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return cString.count != 6
            ? UIColor.gray
            : UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
    }
}
