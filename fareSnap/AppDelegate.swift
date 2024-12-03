//
//  AppDelegate.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 02/12/2024.
//

import Foundation
import UIKit
import UberCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ app: UIApplication, 
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] as Any)

        return handledUberURL
    }
        
    func application(_ application: 
                     UIApplication, 
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)

        return handledUberURL
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
