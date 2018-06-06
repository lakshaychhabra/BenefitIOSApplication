//
//  AppDelegate.swift
//  Benefit
//
//  Created by Delta One on 13/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import GoogleSignIn
import GGLSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
   
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        // Initialize Google sign-in
        GIDSignIn.sharedInstance().clientID = "352356064520-5qtenuib63i9ukps3o6s50m97scg8050.apps.googleusercontent.com"
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
       

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
    }


}

