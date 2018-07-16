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
import FBSDKCoreKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
   
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
       
            // Initialize Google sign-in
            GIDSignIn.sharedInstance().clientID = "352356064520-5qtenuib63i9ukps3o6s50m97scg8050.apps.googleusercontent.com"
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let googleInfo = NSDictionary(contentsOfFile: path),
            let clientId = googleInfo["CLIENT_ID"] as? String {
            GIDSignIn.sharedInstance().clientID = clientId
        }
        
//        GIDSignIn.sharedInstance().delegate = self
//            var configureError: NSError?
//            GGLContext.sharedInstance().configureWithError(&configureError)
//
//
//            assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
            // Facebook Configuration
        
        
            FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
       

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
        
        let fbHandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return googleHandled || fbHandled
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
                     SocketIOManager.sharedInstance.closeConnection()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()

    }

}

