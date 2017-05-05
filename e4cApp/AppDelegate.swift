//
//  AppDelegate.swift
//  E4C_app
//
//  Created by Sam on 3/30/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var manager = FileManager.default
    var tabViewController = CustomTabBarViewController()
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         
         let homeViewController = HomeViewController(nibName:"HomeViewController", bundle: nil)
         
         let navigationController = UINavigationController(rootViewController: homeViewController)
         
         self.window = UIWindow(frame: UIScreen.main.bounds)
         self.window?.rootViewController = navigationController
         self.window?.makeKeyAndVisible() */
        
        UINavigationBar.appearance().tintColor  = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.e4cLightBlue
        
    
        
        let documents = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documents.appendingPathComponent("info.txt")
        
        if let user = NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path) as? User {
            
            UserController.sharedInstance.currentUser = user
            
        }
        
        let homeViewController = HomeViewController()
        let webinarViewController = WebinarViewController()
        let newsViewController = NewsViewController()
        
        
        var communityNavigationController : UINavigationController
        
        if UserController.sharedInstance.currentUser != nil {
            
            let communityViewController = CommunityViewController()
            communityNavigationController = UINavigationController(rootViewController: communityViewController)
        }
        else {
            
            let welcomeViewController = WelcomeViewController()
            communityNavigationController = UINavigationController(rootViewController: welcomeViewController)

        }
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let newsNavigationController = UINavigationController(rootViewController: newsViewController)
        let webinarNavigationController = UINavigationController(rootViewController: webinarViewController)

        
        homeNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        newsNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        webinarNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        communityNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home-50.png"), selectedImage:UIImage(named: "Home-50.png") )
        let webinarTabBarItem = UITabBarItem(title: "Webinars", image:UIImage(named: "Webinar-50.png") , selectedImage: UIImage(named: "Webinar-50.png"))
        let newsTabBarItem = UITabBarItem(title: "News", image:UIImage(named: "News-50.png") , selectedImage: UIImage(named: "News-50.png"))
        let communityTabBarItem = UITabBarItem(title: "Community", image:UIImage(named: "Community-50.png") , selectedImage: UIImage(named: "Community-50.png"))
        
        
        homeNavigationController.tabBarItem = homeTabBarItem
        newsNavigationController.tabBarItem = newsTabBarItem
        webinarNavigationController.tabBarItem = webinarTabBarItem
        communityNavigationController.tabBarItem = communityTabBarItem
        
        
        let controllers = [homeNavigationController, newsNavigationController, webinarNavigationController, communityNavigationController]
        tabViewController.viewControllers = controllers
        
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabViewController
        self.window?.makeKeyAndVisible()
        
        

        
        
        
        return true
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

