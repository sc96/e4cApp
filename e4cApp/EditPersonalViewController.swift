//
//  EditPersonalViewController.swift
//  e4cApp
//
//  Created by Sam on 4/21/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit
import DLRadioButton

class EditPersonalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var firstNameLabel: UITextField!
    

    @IBOutlet weak var lastNameLabel: UITextField!
    
    
    @IBOutlet weak var countryPicker: CountryPicker!
    
    
    @IBOutlet weak var agePicker: UIPickerView!
    
    
    @IBOutlet weak var affiliationPicker: UIPickerView!
    
    
    @IBOutlet weak var professionalPicker: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var maleButton: DLRadioButton!
    
    @IBOutlet weak var femaleButton: DLRadioButton!
    
    @IBOutlet weak var otherButton: DLRadioButton!
    
    @IBOutlet weak var noviceButton: DLRadioButton!
    
    
    @IBOutlet weak var intermediateButton: DLRadioButton!
    
    @IBOutlet weak var expertButton: DLRadioButton!
    
    
    // data arrays for pickerViews
    var ageOptions = ["0-17", "18-24", "25-34", "35-44", "45-64", "65+"];
    var professionalOptions = ["Student", "Practicing Engineer",
                               "Faculty", "Global Development Practitioner", "Retired", "Other"]
    var affiliationOptions = ["Academia", "Industry", "Entrepreneur", "Government",
                              "Nonprofit", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting delegates and datasources
        affiliationPicker.dataSource = self
        affiliationPicker.delegate = self
        
        professionalPicker.dataSource = self
        professionalPicker.delegate = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
        
        
        // save current user to a variable (more succint)
        var currentUser = UserController.sharedInstance.currentUser!
        
        // populating IBOutlets
        firstNameLabel.text = currentUser.firstName
        lastNameLabel.text = currentUser.lastName
        textView.text = currentUser.user_descript
        agePicker.selectRow(currentUser.ageRange , inComponent: 0, animated: false)
        affiliationPicker.selectRow(currentUser.affiliation, inComponent: 0, animated: false)
        professionalPicker.selectRow(currentUser.professionalStatus, inComponent: 0, animated: false)
        countryPicker.selectRow(currentUser.country, inComponent: 0, animated: false)
        
        // populating the pickers
        switch(currentUser.expertise) {
        case 0:
            noviceButton.isSelected = true
            break
        case 1:
            intermediateButton.isSelected = true
            break
        default:
            expertButton.isSelected = true
        }
        
        switch(currentUser.gender) {
        case 0:
            maleButton.isSelected = true
            break
        case 1:
            femaleButton.isSelected = true
            break
        default:
            otherButton.isSelected = true
            break
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if pickerView == affiliationPicker {
            return affiliationOptions.count
        }
        else if pickerView == professionalPicker {
            return professionalOptions.count
        }
        else {
            return ageOptions.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // gets info from respective array
        if pickerView == affiliationPicker {
            return affiliationOptions[row]
        }
        else if pickerView == professionalPicker {
            return professionalOptions[row]
        }
        else {
            return ageOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        return
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        
        var firstName : String
        var lastName : String
        var user_descript : String
        
        // get firstName
        if (firstNameLabel.text == nil) {
            firstName = ""
        }
        else {
            firstName = firstNameLabel.text!
        }
        
    
        // get lastName
        if (lastNameLabel.text == nil) {
            lastName = ""
        }
        else {
            lastName = lastNameLabel.text!
        }
        
        // get description
        if (textView.text == nil) {
            user_descript = ""
        }
        else {
            user_descript = textView.text!
        }
        
        // get the indices of the selectedRows of the pickers
        var profStatus = professionalPicker.selectedRow(inComponent: 0)
        var affiliation = affiliationPicker.selectedRow(inComponent: 0)
        var ageRange = agePicker.selectedRow(inComponent: 0)
        var country = countryPicker.selectedRow(inComponent: 0)
        
        var gender : Int
        var expertise :Int
        
        // get the radioButton's selection
        if (maleButton.isSelected) {
            gender = 0
        }
        else if (femaleButton.isSelected) {
            gender = 1
        }
        else {
            gender = 2
        }
        
        if (noviceButton.isSelected) {
            expertise = 0
        }
        else if (intermediateButton.isSelected) {
            expertise = 1
        }
        else {
            expertise = 2
        }
        
        // call editUser
        UserController.sharedInstance.editUser(firstName: firstName, lastName: lastName, professionalStatus: profStatus, affiliation: affiliation, expertise: expertise, country: country, ageRange: ageRange, gender: gender, id: UserController.sharedInstance.currentUser!.id, description: user_descript, onCompletion: {code, message in
            
            // success
            if code == 200 {
                

               // create success alert
                let alert =  UIAlertController (title: "Saved", message: "Informated Updated", preferredStyle:  UIAlertControllerStyle.alert)
                
                let alertAction1 = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
 
                    self.navigationController?.popViewController(animated: true)
                    print("does it get ehre")
                })
                
                // add the alert
                alert.addAction(alertAction1)
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
            
            // maybe an alert as well to show failure?
            else {
                
                print(message)
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
