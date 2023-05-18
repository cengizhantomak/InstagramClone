//
//  Uzanti+UIColor.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 18.05.2023.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgbDonustur(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
