//
//  AppDelegate.swift
//  SwiftGroupedMessages
//
//  Created by Tiago Bastos on 06/02/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureWindow()
        
        return true
    }

}

extension AppDelegate {
    
    private func configureWindow() {
        
        let window = UIWindow()
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        
        self.window = window
    }
}
