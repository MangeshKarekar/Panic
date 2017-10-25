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
            return "#2E2E2E".colorFromHex(alpha: 1.0)
        }
    }
}

public enum ButtonCode: String{
    case adult = "Adults"
    case kids = "Kids"
    
    var imageNames: (red: String?, yellow: String?, green: String?){
        
        switch self {
        case .adult:
            return (red: nil, yellow: nil, green: nil)
        case .kids:
            return (red: "kidFriendlyRed", yellow: "kidFriendlyYellow", green: "kidFriendlyGreen")
        }
        
    }
    
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
    
    var buttonImageNames: (red: String?, yellow: String?, green: String?)?{
        get{
            let buttonCode = ButtonCode(rawValue: homeButtonCode)
            return buttonCode?.imageNames
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
