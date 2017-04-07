//
//  WebinarPageViewController.swift
//  E4C_app
//
//  Created by Sam on 3/31/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class WebinarPageViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorDateLabel: UILabel!
    
    @IBOutlet weak var sectorLabel: UILabel!
    
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    var videotitle : String?
    var videoUrl : String?
    var author : String?
    var sector: String?
    var date : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorites-50.png"),  style: .plain,  target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = add_button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAction(sender:UIBarButtonItem){
        
        print("fake favorited")
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
