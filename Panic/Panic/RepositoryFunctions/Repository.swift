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
                    let colors = generateColors()
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
    
    
    private func generateColors() -> [Object]{
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
    
    
    func getColors()throws -> Results<ColorsEntity>{
        do{
            let realm = try getRealm()
            return realm.objects(ColorsEntity.self)
        }catch{
            throw error
        }
    }
    
    func saveColorEntity(_ colorEntity: ColorsEntity)throws{
        do{
            let realm = try getRealm()
            try realm.write {
                realm.add(colorEntity, update: true)
            }
        }catch{
            throw error
        }
    }
    
    func addOrupdateContacts(_ contacts: [ContactsEntity] ,forColor colorName: String)throws{
        let realm = try getRealm()
        try realm.write {
            realm.add(contacts, update: true)
        }
    }
    
    func getContacts(forColor color: String)throws -> Results<ContactsEntity>{
        let realm = try getRealm()
        return realm.objects(ContactsEntity.self).filter("color = '\(color)'")
    }
    
    func deleteContact(forName name: String)throws{
        let realm = try getRealm()
        let contacts = realm.objects(ContactsEntity.self).filter("name = '\(name)'")
        try realm.write {
            realm.delete(contacts)
        }
    }
    
    
    //MARK: Common functions
    private func getRealm()throws -> Realm{
        
        do {
            let realm = try Realm()
            return realm
        }catch{
            throw error
        }
    }
    
}
