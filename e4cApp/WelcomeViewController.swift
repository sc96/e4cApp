//
//  WelcomeViewController.swift
//  E4C_app
//
//  Created by Sam on 4/5/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.e4cLightBlue
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // navigate to LogInViewController
    @IBAction func signInAction(_ sender: UIButton) {
        
        
        let loginViewController = LogInViewController();
        self.navigationController?.pushViewController(loginViewController, animated: false)
    }
    
    // navigate to SignUpViewController    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        let signUpViewController = SignUpViewController();
        
        self.navigationController?.pushViewController(signUpViewController, animated: false)
        
    
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
