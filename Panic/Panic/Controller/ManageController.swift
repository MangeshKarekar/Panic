//
//  ManageController.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation

class ManageController {
    
    static let sharedInstance = ManageController()
    
    private let repository = Repository.sharedInstance
    
    init(){}
    
    //MARK: create colors
    func createColors() throws{
        do {
            try repository.createColors()
        } catch {
            throw error
        }
    }
}
