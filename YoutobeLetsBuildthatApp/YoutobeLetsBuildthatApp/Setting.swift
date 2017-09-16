//
//  Setting.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 18/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import Foundation

class Setting : NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
