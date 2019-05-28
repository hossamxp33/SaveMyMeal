//
//  AppDelegate.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/15/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import Stripe
import IQKeyboardManager
import FBSDKCoreKit
import FBSDKLoginKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   //private let publishableKey = "pk_test_TT3A5MmBSazotjxYXWkBDhh600OpJYCikz"
    
    private let publishableKey: String = "pk_test_hnUZptHh36jRUveejCXqRoVu"
    private let baseURLString: String = "https://rocketrides.io"
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        UITabBar.appearance().tintColor =  UIConstants.AppColor
        //UINavigationBar.appearance().barTintColor = UIConstants.AppColor

        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        initStripe()
        init_OneSignal(launchOptions: launchOptions)
        PayPalMobile.initializeWithClientIds(forEnvironments: [
        PayPalEnvironmentSandbox: "Aery7sa0Sq-5SNTtxA1h9aKtJKlotms4PVRuoq7jNmyTea2_PLt8rPsfWdcYtT2b7xanxsbuJ-CQFxf4"])
    
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
    
        return true
    }
   
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation] as! String)
        return handled ?? false
    }
    
    
    
    
    
    func init_OneSignal(launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "495631db-654d-45cf-9fb6-c4492c477f1d",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    func initStripe(){
        STPPaymentConfiguration.shared().companyName = "Hadeer kamel" // "Rocket Rides"
        
        if !publishableKey.isEmpty {
            STPPaymentConfiguration.shared().publishableKey = publishableKey
        }
       //MainAPIClient.shared.baseURLString = baseURLString
//
//        if !appleMerchantIdentifier.isEmpty {
//            STPPaymentConfiguration.shared().appleMerchantIdentifier = appleMerchantIdentifier
//        }
        
        // Stripe theme configuration
//        STPTheme.default().primaryBackgroundColor = .riderVeryLightGrayColor
//        STPTheme.default().primaryForegroundColor = .riderDarkBlueColor
//        STPTheme.default().secondaryForegroundColor = .riderDarkGrayColor
//        STPTheme.default().accentColor = .riderGreenColor
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

