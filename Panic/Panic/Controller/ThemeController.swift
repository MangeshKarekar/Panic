//
//  ThemeController.swift
//  Panic
//
//  Created by Mangesh Karekar on 25/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

class ThemeController{
    
    static let sharedInstance = ThemeController()
    private let repository = ThemeRepository.sharedInstance

    init(){}

    func createTheme()throws{
        try repository.createTheme()
    }
    
    func getTheme()throws ->ThemeEntity{
        return try repository.getTheme()
    }
    
    func updateTheme(_ theme: ThemeEntity, withDarkMode value: Bool)throws{
        try repository.updateTheme(theme, withDarkMode: value)
    }
    
}
