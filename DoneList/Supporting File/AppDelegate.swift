//
//  AppDelegate.swift
//  DoneList
//
//  Created by Farhan Qazi on 4/15/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//

import UIKit
import Firebase
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
//        let defaultPath = Realm.Configuration.defaultConfiguration.path!
//        try FileManager.defaultManager().removeItemAtPath(defaultPath)
        return true
    }
    
    
    
    
}














