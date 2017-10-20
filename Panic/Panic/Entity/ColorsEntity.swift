//
//  RedEntity.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class ColorsEntity: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var message = "Please help me."
    @objc dynamic var locationStatus = false
    var color: UIColor{
        get{
            switch name{
            case Colors.redString: return Colors.panicRed
            case Colors.greenString: return Colors.panicGreen
            case Colors.yellowString: return Colors.panicYellow
            default: return UIColor.white
            }
        }
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
