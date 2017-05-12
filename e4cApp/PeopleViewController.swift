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
        aboutText.text = about!
        
        // This is Dummy. TODO: switch string based on Int. Should correspond to the CountryPicker
        countryLabel.text = "Usa"
        
        if professional == 0 {
            professionalLabel.text = "Student"
        }
        
        else if professional == 1 {
            professionalLabel.text = "Practicing Engineer"
            
        }
        
        else if professional == 2 {
            professionalLabel.text = "Faculty"
            
        }
        
        else if professional == 3 {
            professionalLabel.text = "GD Practioner"
            
        }
        
        else if professional == 4 {
            professionalLabel.text = "Retired"
            
        }
        
        else {
            
            professionalLabel.text = "Other"
            
        }
        
        if affiliation == 0 {
            affiliationLabel.text = "Academia"
        }
            
        else if affiliation == 1 {
            affiliationLabel.text = "Industry"
            
        }
            
        else if affiliation == 2 {
            affiliationLabel.text = "Entrepeneur"
            
        }
            
        else if affiliation == 3 {
            affiliationLabel.text = "Government"
            
        }
            
        else if affiliation == 4 {
            affiliationLabel.text = "Nonprofit"
            
        }
            
        else {
            affiliationLabel.text = "Other"
            
        }
        
        
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
