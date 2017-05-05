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

    
    var sectors : [String] = ["Water", "Energy", "Health", "Housing", "Agriculture", "Sanitation", "ICT", "Transport"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleView.textColor = UIColor.lightGray
        
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
        
        
        return sectors.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
    
        return sectors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        return
    }
    
    /*
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 12)
        
        label.text = sectors[row]
        
        
        
        return label
        
    }*/
    
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
        
        if (titleView.text == "" || textView.text == "" || titleView.text == "Title") {
        
        let alert =  UIAlertController (title: "Error" , message: "Please fill out all forms.", preferredStyle:  UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
            return
        })
        
        alert.addAction(alertAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
            
        }
        
        else {
            
            addProject(onCompletion: {resultsCount, error in
                
                
                
                if error == nil {
                    
                    
                    let alert =  UIAlertController (title: "Success", message: "Project Submitted", preferredStyle:  UIAlertControllerStyle.alert)
                    
                    let alertAction1 = UIAlertAction( title: "Ok" , style: .cancel, handler: { action in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    
                    })
                    
                    alert.addAction(alertAction1)
                    self.navigationController?.present(alert, animated: true, completion: nil)
 
                    
                }
                    
                else {
                    print(error!)
                }
            })
            
        }
        

        
        
    }
    
    
    func addProject(onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :String]
        
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
        
        
        parameters = ["title" : title, "owner": owner, "description" : projectDescript, "sector" : sector, "owner_name" : owner_name, "owner_email" : owner_email]
        
    
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/createproject", method: .post, parameters: parameters)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                
                print(json)
                
                
                // get 10 for now
                
                for i in 0...9 {
                    
                    print("a")
                    
                }
                onCompletion(200,nil)
                
                
            }
                
            else {
                
                
                let message = "error"
                onCompletion(100, message)
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
