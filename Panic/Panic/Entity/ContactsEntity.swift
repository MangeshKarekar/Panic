//
//  Contacts.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsEntity: Object{
    @objc dynamic var name = ""
    let contact = List<PhoneEntity>()
}
