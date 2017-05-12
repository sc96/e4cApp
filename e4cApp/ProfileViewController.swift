//
//  ProfileViewController.swift
//  e4cApp
//
//  Created by Sam on 4/21/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    var manager = FileManager.default
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func favoritesPressed(_ sender: UIButton) {
        
        let favoritesViewController = FavoritesViewController()
        self.navigationController?.pushViewController(favoritesViewController, animated: true)
        
        
    }
    
    // navigates to EditPersonalViewController
    @IBAction func personalPressed(_ sender: UIButton) {

        
        let editPersonalViewController = EditPersonalViewController()
        self.navigationController?.pushViewController(editPersonalViewController, animated: true)
        
        
    }

    // logout
    @IBAction func tempLogOut(_ sender: UIButton) {
        
        
        
        if UserController.sharedInstance.currentUser != nil {
            
            UserController.sharedInstance.tempArticleFilters = UserController.sharedInstance.currentUser!.articleFilters
            UserController.sharedInstance.tempWebinarFilters = UserController.sharedInstance.currentUser!.webinarFilters
            UserController.sharedInstance.currentUser = nil
            
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("info.txt")
            
            // removing current user from the filesystem
            if manager.fileExists(atPath: fileUrl.path) {
                
                do {
                    try manager.removeItem(atPath: fileUrl.path)
                    
                } catch let error as NSError {
                    
                    print("Error \(error.domain)")
                }
                
            
            }
            
            
            // instantiating WelcomeViewController
            let welcomeViewController = WelcomeViewController()
            var communityNavigationController = UINavigationController(rootViewController: welcomeViewController)
            
            // creating TabBarItem
            let communityTabBarItem = UITabBarItem(title: "Community", image:UIImage(named: "Community-50.png") , selectedImage: UIImage(named: "Community-50.png"))
            communityNavigationController.tabBarItem = communityTabBarItem
            
            
            // appearance
            communityNavigationController.navigationBar.tintColor = UIColor.white
            communityNavigationController.navigationBar.barTintColor = UIColor.supportRed
            
            
            // changing the Tabbar's fourth tab
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.tabViewController.viewControllers![3] = communityNavigationController
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
