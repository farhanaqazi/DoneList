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
import RealmSwift // Step2(1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
// Step 2 (2): Add code to write migration as per new schema in Line No. 25: 
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: Category.className()) { oldObject, newObject in
                        newObject!["userId"] = ""
                    }
                }
        })

        
//        let defaultPath = Realm.Configuration.defaultConfiguration.path!
//        try FileManager.defaultManager().removeItemAtPath(defaultPath)
        return true
    }
    
    
    
    
}














