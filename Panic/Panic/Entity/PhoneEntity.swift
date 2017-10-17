//
//  PhoneNumbers.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

class PhoneEntity: Object{
    @objc dynamic var name = ""
    @objc dynamic var number = ""
}
