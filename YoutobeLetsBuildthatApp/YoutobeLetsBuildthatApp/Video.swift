//
//  Video.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 17/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import Foundation
import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
        
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {

        if key == "channel" {
            let channelDict = value as! [String: AnyObject]
            
            let channel = Channel()
            channel.setValuesForKeys(channelDict)
            
            self.channel = channel
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}
