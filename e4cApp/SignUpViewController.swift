//
//  SignUpViewController.swift
//  e4cApp
//
//  Created by Sam on 4/13/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit
import DLRadioButton

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var retypeField: UITextField!
    
    
    @IBOutlet weak var affiliationPicker: UIPickerView!
    
    @IBOutlet weak var professionalPicker: UIPickerView!
    
    @IBOutlet weak var countryPicker: CountryPicker!
  
    
    @IBOutlet weak var agePicker: UIPickerView!
    
    
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
 
    var manager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // setting pickers' delegates and datasources
        affiliationPicker.dataSource = self
        affiliationPicker.delegate = self
        
    
        professionalPicker.dataSource = self
        professionalPicker.delegate = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // getting value from its respective Array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
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
    
    
    // pretty basic for now, but can easily add more requirements, contain an uppercase, etc
    func passwordVerify (password : String, retype: String) -> Bool {
        
        
        if (password != retype) {
            return false
        }
        
        return password.characters.count >= 8
        
        
    }
    
    // SignUp button pressed
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        var email : String = ""
        var password : String = ""
        
        
        // making sure the text fields are entered
        if (emailField.text == "" || passwordField.text == "" || retypeField.text == "") {
            
            let alert = UIAlertController(title: "Error", message: "All fields must be entered", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                
                return
                
            })
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
            
            
        // fields are entered
        else {
            
            email = emailField.text!
            password = passwordField.text!
            
        }
        
        // verify password
        if (!passwordVerify(password: passwordField.text!, retype: retypeField.text!)) {
            
            let alert = UIAlertController(title: "Error", message: "Password must be at least 8 characters long", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                
                return
                
            })
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        

        // getting info from IBOutlets
        var professionalStatus = professionalPicker.selectedRow(inComponent: 0)
        var affiliation = affiliationPicker.selectedRow(inComponent: 0)
        var country = countryPicker.selectedRow(inComponent: 0)
        var ageRange = agePicker.selectedRow(inComponent: 0)
        
        var gender :Int = -1
        var expertise : Int = -1
        
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
        else if(intermediateButton.isSelected) {
            expertise = 1
        }
        else {
            expertise = 2
        }
        
        
        // All fields must be entered
        if (gender == -1 || expertise == -1) {
            
            let alert = UIAlertController(title: "Error", message: "All fields must be entered", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                
                return
                
            })
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        
        
        // registering user
        UserController.sharedInstance.registerUser(email: email, password: password, professionalStatus: professionalStatus, affiliation: affiliation, expertise: expertise, country: country, ageRange: ageRange, gender: gender, onCompletion: {user, message in

            
            // success
            if user != nil {
                
                
                // set current User
                UserController.sharedInstance.currentUser = user
                
                // save current user to the phone's memory
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileUrl = documents.appendingPathComponent("info.txt")
                NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                
                
                
                // instantiating the CommunityViewController
                let communityViewController = CommunityViewController()
                
                // creating a new navBar and setting the root Viewcontroller
                var communityNavigationController = UINavigationController(rootViewController: communityViewController)
                
                // creating tab Bar item
                let communityTabBarItem = UITabBarItem(title: "Community", image:UIImage(named: "Community-50.png") , selectedImage: UIImage(named: "Community-50.png"))
                communityNavigationController.tabBarItem = communityTabBarItem
                

                // appearance
                communityNavigationController.navigationBar.tintColor = UIColor.white
                communityNavigationController.navigationBar.barTintColor = UIColor.supportRed
                
                
                // changing the fourth tab
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.tabViewController.viewControllers![3] = communityNavigationController
                
            }
                
                
            // error signing up.
            else {
                
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                    
                    return
                    
                })
                self.navigationController?.present(alert, animated: true, completion: nil)

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
