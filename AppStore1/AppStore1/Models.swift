//
//  Models.swift
//  AppStore1
//
//  Created by Tiago Bastos on 03/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String : AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}


class AppCategory: NSObject {
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps) -> ()){
        let UrlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: UrlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                
                let featuredapps = FeaturedApps()
                featuredapps.setValuesForKeys(json)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredapps)
                })
                
            } catch let err {
                print(err)
            }
        }) .resume()
    }
    
    
    static func sampleAppCategories() -> [AppCategory] {
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        let frozenApp = App()
        frozenApp.name = "Disney build it: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = NSNumber(floatLiteral: 3.99)
        apps.append(frozenApp)
        
        bestNewAppsCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGamesApps = [App]()
        
        let telapaintApp = App()
        telapaintApp.name = "Telapaint"
        telapaintApp.category = "Games"
        telapaintApp.imageName = "telepaint"
        telapaintApp.price = NSNumber(floatLiteral: 2.99)
        
        bestNewGamesApps.append(telapaintApp)
        
        bestNewGamesCategory.apps = bestNewGamesApps
        
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
}


class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
    var screenshots: [String]?
    var desc: String?
    var appInformation: AnyObject?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}
