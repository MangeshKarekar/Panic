//
//  ThemeEntity.swift
//  Panic
//
//  Created by Mangesh Karekar on 24/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

public enum ColorCode: Int{
    case light = 1
    case dark = 2
    
    var color: UIColor{
        switch self {
        case .light:
            return UIColor.white
        case .dark:
            return UIColor.brown
        }
    }
}

public enum ButtonCode: Int{
    case adult = 1
    case kids = 2
}

class ThemeEntity: Object {
    @objc dynamic var colorCode = ColorCode.light.rawValue
    @objc dynamic var buttonCode = ButtonCode.adult.rawValue
}
