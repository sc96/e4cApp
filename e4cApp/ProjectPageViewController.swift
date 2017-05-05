//
//  ProjectPageViewController.swift
//  e4cApp
//
//  Created by Sam on 4/14/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class ProjectPageViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var sectorLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    
    var projectTitle : String?
    var projectDescript : String?
    var sector : String?
    var name : String?
    var email : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = projectTitle!
        textView.text = projectDescript!
        sectorLabel.text = sector!
        nameLabel.text = name!
        contactLabel.text = email!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
