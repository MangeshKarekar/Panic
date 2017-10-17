//
//  ManageController.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

class ManageController {
    
    static let sharedInstance = ManageController()
    
    private let repository = Repository.sharedInstance
    
    init(){}
    
    //MARK: create colors
    func createColors() throws{
        try repository.createColors()
    }
    
    func getColors()throws ->Results<ColorsEntity>{
        return try repository.getColors()
    }
}
