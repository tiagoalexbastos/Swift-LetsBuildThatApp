//
//  Tweet.swift
//  TwitterLBTA
//
//  Created by Tiago Bastos on 24/07/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet: JSONDecodable {
    
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)
        
        self.message = json["message"].stringValue
    }
    
    
}
