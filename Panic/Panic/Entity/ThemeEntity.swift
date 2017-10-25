//
//  ThemeEntity.swift
//  Panic
//
//  Created by Mangesh Karekar on 24/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

public enum ColorCode: String{
    case light = "Light"
    case dark = "Dark"
    
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
    
    @objc dynamic var id = 1
    
    @objc dynamic var themeColorCode = ColorCode.light.rawValue
    @objc dynamic var homeButtonCode = ButtonCode.adult.rawValue
    @objc dynamic var autoDarkMode = false
    var themeColor: UIColor?{
        get{
            let colorCode = ColorCode(rawValue: themeColorCode)
            return colorCode?.color
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
