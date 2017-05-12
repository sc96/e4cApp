//
//  AddProjectViewController.swift
//  e4cApp
//
//  Created by Sam on 5/4/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var titleView: UITextView!

    // pickerView's data array
    var sectors : [String] = ["Water", "Energy", "Health", "Housing", "Agriculture", "Sanitation", "ICT", "Transport"]

    override func viewDidLoad() {
        super.viewDidLoad()

    
        // setting delegate and datasource
        pickerView.delegate = self
        pickerView.dataSource = self
        titleView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // 8 sectors
        return sectors.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return sectors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        return
    }
    

    
    // Placeholder text logic for the Title textView
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = "Title"
            textView.textColor = UIColor.lightGray
        }
    }
    
    

    @IBAction func submitPressed(_ sender: UIButton) {
        
        
        // Not all the forms were filled
        if (titleView.text == "" || textView.text == "" || titleView.text == "Title") {
        
        let alert =  UIAlertController (title: "Error" , message: "Please fill out all forms.", preferredStyle:  UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
            return
        })
        
        alert.addAction(alertAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
            
        }
        
        // forms were all filled
        else {
            
            
            // Tries to addProject
            addProject(onCompletion: {resultsCount, error in
                
                
                // Success
                if error == nil {
                    
                    // Adding alert
                    let alert =  UIAlertController (title: "Success", message: "Project Submitted", preferredStyle:  UIAlertControllerStyle.alert)
                    
                    let alertAction1 = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    
                    })
                    
                    alert.addAction(alertAction1)
                    self.navigationController?.present(alert, animated: true, completion: nil)
                    
                }
                
                // Unsuccessful (Maybe also an alert?)
                else {
                    print(error!)
                }
            })
            
        }
        

        
        
    }
    
    
    // add Project
    func addProject(onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :String]
        
        
        // Gets information for API Call
        let title = titleView.text!
        let owner_name = UserController.sharedInstance.currentUser!.firstName + UserController.sharedInstance.currentUser!.lastName
        let projectDescript = textView.text!
        let owner = UserController.sharedInstance.currentUser!.id
        let owner_email  = UserController.sharedInstance.currentUser!.email
        
        var sector : String
        
        
        switch pickerView.selectedRow(inComponent: 0) {
            
        case 0 :
            sector = "Water"
            
        case 1 :
            sector = "Energy"
        case 2 :
            sector = "Health"
        case 3 :
            sector = "Housing"
        case 4 :
            sector = "Agriculture"
        case 5 :
            sector = "Sanitation"
        case 6 :
            sector = "ICT"
        case 7 :
            sector = "Transport"
        default:
            sector = "Water"
            
            
        }
        
        
        // parameter for the API Call
        parameters = ["title" : title, "owner": owner, "description" : projectDescript, "sector" : sector, "owner_name" : owner_name, "owner_email" : owner_email]
        
    
        
        // creating a request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/createproject", method: .post, parameters: parameters)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            // request was successful
            if (responseCode == 200) {
                
                
                onCompletion(responseCode,nil)
                
                
            }
               
            // request was not successful
            else {
                
                
                let message = "Connection Error"
                onCompletion(responseCode, message)
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
