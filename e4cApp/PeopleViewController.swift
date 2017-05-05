//
//  PeopleViewController.swift
//  e4cApp
//
//  Created by Sam on 4/21/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var professionalLabel: UILabel!
    
    
    @IBOutlet weak var affiliationLabel: UILabel!
    
    
    
    @IBOutlet weak var aboutText: UITextView!
    
    
    var name : String?
    var email : String?
    var country : Int?
    var professional : Int?
    var affiliation : Int?
    var about : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = name!
        emailLabel.text = email!
        countryLabel.text = "Usa"
        affiliationLabel.text = "Student"
        professionalLabel.text = "Academia"
        aboutText.text = about!
        
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
