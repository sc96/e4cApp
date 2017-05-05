//
//  LogInViewController.swift
//  e4cApp
//
//  Created by Sam on 4/7/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit



class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var manager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        let communityViewController = CommunityViewController();
        
        
        if (emailField.text == "" || passwordField.text == "") {
            
            
            messageLabel.text = "Please enter all fields"
            return
        }
        
        var email = emailField.text!
        var password = passwordField.text!
        
        UserController.sharedInstance.loginUser(email: email, password: password, onCompletion: {user, message in
            
            if user != nil {
                
                UserController.sharedInstance.currentUser = user
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileUrl = documents.appendingPathComponent("info.txt")
                NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                
                let alert =  UIAlertController (title: "Welcome, " + user!.firstName , message: "Login successful.", preferredStyle:  UIAlertControllerStyle.alert)
                
                let alertAction1 = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
                    
                 
                    let communityViewController = CommunityViewController()
                    var communityNavigationController = UINavigationController(rootViewController: communityViewController)
                    let communityTabBarItem = UITabBarItem(title: "Community", image:UIImage(named: "Community-50.png") , selectedImage: UIImage(named: "Community-50.png"))
                    communityNavigationController.tabBarItem = communityTabBarItem
                    
                    
                    communityNavigationController.navigationBar.tintColor = UIColor.white
                    communityNavigationController.navigationBar.barTintColor = UIColor.supportRed
                    
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.tabViewController.viewControllers![3] = communityNavigationController

                        
                        
                        
                        
                    })
                
                alert.addAction(alertAction1)
                self.navigationController?.present(alert, animated: true, completion: nil)
               
                
                
            }
            
            else {
                
                self.messageLabel.text = message
            }
            
        })
          
        
        
        
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
