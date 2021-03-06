//
//  ManageController.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import RealmSwift
import Contacts

class ManageController {
    
    static let sharedInstance = ManageController()
    
    private let repository = ColorRepository.sharedInstance
    
    typealias colorsTuple = (red: Color?, yellow: Color?, green: Color?)
    
    init(){}
    
    //MARK: create colors
    
    func createColors() throws{
        try repository.createColors()
    }
    
    func getColors()throws -> Results<ColorsEntity>{
        let colors = try repository.getColors()
        return  colors
    }
    
    
    func getColorsTuple()throws ->colorsTuple{
        let colors = try repository.getColors()
        return  convertColorsToModel(results: colors)
    }
    
    
    private func convertColorsToModel(results: Results<ColorsEntity>) -> colorsTuple{
        
        var red: Color?
        var yellow: Color?
        var green: Color?

        if let redEntity = results.filter("name = '\(Colors.redString)'").first{
             red = Color(colorEntity: redEntity)
        }
        if let yellowEntity = results.filter("name = '\(Colors.yellowString)'").first{
            yellow = Color(colorEntity: yellowEntity)
        }
        if let greenEntity = results.filter("name = '\(Colors.greenString)'").first{
            green = Color(colorEntity: greenEntity)
        }

        return (red: red, yellow: yellow, green: green)
    }
    
    
    func getContacts(cnContacts: [CNContact], completion:@escaping (_ contacts: List<ContactsEntity>)-> Void){
        DispatchQueue.global().async {
            let contacts = List<ContactsEntity>()
            for contact in cnContacts{
                let name = contact.givenName + " " + contact.familyName
                let contactEntity = ContactsEntity()
                contactEntity.name = name
                for phone in contact.phoneNumbers{
                    let phoneEntity = PhoneEntity()
                    phoneEntity.name = name
                    phoneEntity.number = phone.value.stringValue
                    contactEntity.phones.append(phoneEntity)
                }
                contacts.append(contactEntity)
            }
            completion(contacts)
        }
    }
    
    
    func addOrupdateContacts(_ contacts: [CNContact] ,forColor colorName: String)throws{
        let contactEntities:[ContactsEntity] = contacts.map{
            let name = $0.givenName + " " + $0.familyName
            let contactEntity = ContactsEntity()
            contactEntity.id = name+colorName
            contactEntity.name = name
            contactEntity.color = colorName
            for phone in $0.phoneNumbers{
                let phoneEntity = PhoneEntity()
                phoneEntity.name = name
                phoneEntity.number = phone.value.stringValue
                contactEntity.phones.append(phoneEntity)
            }
            return contactEntity
        }
        try repository.addOrupdateContacts(contactEntities, forColor: colorName)
    }
    
    func getContacts(forColor color: String)throws->Results<ContactsEntity>{
        
        return try repository.getContacts(forColor: color)
    }
    
    func deleteContact(forName name: String)throws{
        try repository.deleteContact(forName: name)
    }
    
    func saveColor(color: Color)throws{
        let colorEntity = ColorsEntity()
        colorEntity.name = color.name
        colorEntity.message = color.message
        colorEntity.locationStatus = color.locationStatus
        try repository.saveColorEntity(colorEntity)
    }
}
