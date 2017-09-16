//
//  User.swift
//  GameofChats
//
//  Created by Tiago Bastos on 28/07/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit


class UserFB: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}

