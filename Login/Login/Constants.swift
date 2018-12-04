//
//  Constants.swift
//  Messaging Demo
//
//  Created by Danielle Nunez on 11/27/18.
//  Copyright © 2018 Danielle Nunez. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
