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
    
    static let sharedInstance = Repository()
    
    init(){}
    
    func createColors()throws{

        do{
            let realm = try getRealm()
            let colors = realm.objects(ColorsEntity.self)
            if colors.count == 0{
                try realm.write {
                    let colors = getcolors()
                    for color in colors{
                        realm.add(color, update: true)
                    }
                }
            }
        }catch{
            print(error)
            throw error
        }
    }
    
    
    private func getcolors() -> [Object]{
        let red = ColorsEntity()
        red.name = Colors.redString
        red.message = "Please Help me."
        
        let yellow = ColorsEntity()
        yellow.name = Colors.yellowString
        yellow.message = "Please Help me."
        
        let green = ColorsEntity()
        green.name = Colors.greenString
        green.message = "Please Help me."
        
        return [red,yellow,green]
    }
    
    
    private func getRealm()throws -> Realm{
        
        do {
            let realm = try Realm()
            return realm
        }catch{
            throw error
        }
    }
    
}
