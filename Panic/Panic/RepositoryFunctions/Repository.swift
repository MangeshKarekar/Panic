//
//  Repository.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

class Repository {
    
    // static let sharedInstance = Repository()
    
    init(){}
    //MARK: Common functions
    
    func getRealm()throws -> Realm{
        
        do {
            let realm = try Realm()
            return realm
        }catch{
            throw error
        }
    }
    
}
