//
//  Contact.swift
//  Login
//
//  Created by Danielle Nunez on 12/3/18.
//  Copyright © 2018 James Clark. All rights reserved.
//


import Foundation

class Contact {
    
    var contactName: String?
    var characterClass: String?
    
    
    //Constructor used when creating a contact.
    init(contactName: String, characterClass: String) {
        self.contactName = contactName
        self.characterClass = "<insertImagePath>"
    }
    
    // Getter for the task name.
    func getName() -> String {
        return self.contactName!
    }
    
    // Getter for the status.
    func getCharacterClass() -> String {
        return self.characterClass!
    }
}

