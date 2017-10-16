//
//  Colors.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import UIKit

//MARK: Colors

enum PanicColor {
    case red
    case yellow
    case green
}

class Colors {
    private static let red = "FA2E31"
    private static let yellow = "FFD501"
    private static let green = "A2D345"

    
    static var panicRed: UIColor{
        get {
            return red.colorFromHex(alpha: 1.0)
        }
    }
    
    static var panicYellow: UIColor{
        get {
            return yellow.colorFromHex(alpha: 1.0)
        }
    }
    
    static var panicGreen: UIColor{
        get {
            return green.colorFromHex(alpha: 1.0)
        }
    }
}
