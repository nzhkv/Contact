//
//  Contact.swift
//  Contact
//
//  Created by Nikolay Zhukov on 11.07.2023.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set } // name
    var phone: String { get set } // number
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}

protocol ContactStorageProtocol {
    func load() -> [ContactProtocol]
    func save(contacts: [ContactProtocol])
}

class ContactStorage: ContactStorageProtocol {
    private var storage = UserDefaults.standard
    private var storageKey = "contacts"
    
    private enum ContactKey: String {
        case title
        case phone
    }
    
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let number = contact[ContactKey.phone.rawValue] else { continue }
            resultContacts.append(Contact(title: title, phone: number))
        }
        return resultContacts
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach { contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
}
