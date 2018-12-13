//
//  Potential Match.swift
//  Pyromance
//
//  Created by Danielle Nunez on 12/12/18.
//

import Foundation

class PotentialMatch {
    let username: String!
    let image: String!
    let server: String!
    let level: String!
    
    init(username: String, image: String, server: String, level: String) {
        self.username = username
        self.image = image
        self.server = server
        self.level = level
    }
    
    init(username: String, image: String) {
        self.username = username
        self.image = image
        self.server = "Stormrage"
        self.level = "120"
    }
    
    /*
     Returns the username in the form <name>-<server>
     i.e. Skarmorite-Stormrage
     */
    func getFullUsername() -> String{
        return self.username + "-" + self.server
    }
}
