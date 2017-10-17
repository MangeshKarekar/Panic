//
//  Color.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

struct Color {
    
    var name: String
    var message: String
    var locationStatus: Bool
    var contacts: List<ContactsEntity>
    
    init(colorEntity: ColorsEntity) {
        self.name = colorEntity.name
        self.message = colorEntity.message
        self.locationStatus = colorEntity.locationStatus
        self.contacts = colorEntity.contacts
    }
}
