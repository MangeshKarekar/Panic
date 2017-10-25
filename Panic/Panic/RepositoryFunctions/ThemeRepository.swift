//
//  ThemeRepository.swift
//  Panic
//
//  Created by Mangesh Karekar on 25/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift

enum ThemeError: Error{
    
    case themeDoesNotExist
}

class ThemeRepository: Repository{
    
    
    static let sharedInstance = ThemeRepository()

    func createTheme()throws{
        let realm = try getRealm()
        let themes = realm.objects(ThemeEntity.self)
        if themes.count == 0{
            let theme = ThemeEntity()
            try realm.write {
                realm.add(theme)
            }
        }
    }
    
    
    func getTheme()throws -> ThemeEntity{
        let realm = try getRealm()
        let themes = realm.objects(ThemeEntity.self)
        if let theme = themes.first{
            return theme
        }else{
            throw ThemeError.themeDoesNotExist
        }
    }
    
    func updateTheme(_ theme: ThemeEntity, withDarkMode value: Bool)throws{
        let realm = try getRealm()
        try realm.write {
            theme.autoDarkMode = value
            realm.add(theme, update: true)
        }
    }
    
}
