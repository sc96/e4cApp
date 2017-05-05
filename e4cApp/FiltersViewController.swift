//
//  FiltersViewController.swift
//  e4cApp
//
//  Created by Sam on 4/7/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var type :String?
    var manager = FileManager.default
    
    
    var sectors : [String] = ["Featured", "Water", "Energy", "Health", "Housing", "Agriculture", "Sanitation", "ICT", "Transport"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = type
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FiltersTableViewCell", bundle: nil), forCellReuseIdentifier: "filtersCell")
        
        tableView.allowsMultipleSelection = true
        
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 9;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell:FiltersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "filtersCell") as! FiltersTableViewCell
        
        let sector = sectors[indexPath.row]
        
        cell.titleLabel.text = sector
        
        
        // switch images here
        switch sector {
            
            case "Water" :
                cell.imageLabel.image = UIImage(named: "Water-50.png")
                cell.backgroundColor = UIColor.waterColor
            case "Energy" :
                cell.imageLabel.image = UIImage(named: "Idea-50.png")
                cell.backgroundColor = UIColor.energyColor
            case "Health" :
                cell.imageLabel.image = UIImage(named: "Clinic-50.png")
                cell.backgroundColor = UIColor.healthColor
            case "Housing" :
                cell.imageLabel.image = UIImage(named: "Tent-50.png")
                cell.backgroundColor = UIColor.housingColor
            case "Agriculture" :
                cell.imageLabel.image = UIImage(named: "Compost Heap-50.png")
                cell.backgroundColor = UIColor.agricultureColor
            case "Sanitation" :
                cell.imageLabel.image = UIImage(named: "Soap-50.png")
                cell.backgroundColor = UIColor.sanitationColor
            case "ICT" :
                cell.imageLabel.image = UIImage(named: "Smartphone RAM-50.png")
                cell.backgroundColor = UIColor.ICTColor
            case "Transport" :
                cell.imageLabel.image = UIImage(named: "Shuttle-50.png")
                cell.backgroundColor = UIColor.transportColor
            default:
                cell.imageLabel.image = nil
                cell.backgroundColor = UIColor.white
            
            
        }
        
        // some cell settings
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        
        
        if (UserController.sharedInstance.currentUser != nil) {
        
            if (type == "Webinars") {
        
       
            
            if (UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] == false) {
                cell.accessoryType = .none
                
            }
            
            else {
                cell.accessoryType = .checkmark
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
        }
        
            else {
            
        
            
                if (UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] == false) {
                cell.accessoryType = .none
                
                }
                
                else {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
        }
        
        else {
            
            if (type == "Webinars") {
                
                
                if (UserController.sharedInstance.tempWebinarFilters[indexPath.row] == false) {
                    cell.accessoryType = .none
                    
                }
                    
                else {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
                
            else {
                
                
                
                if (UserController.sharedInstance.tempArticleFilters[indexPath.row] == false) {
                    cell.accessoryType = .none
                    
                }
                    
                else {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
            
        }
     
        
        print(cell.isSelected);
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if (UserController.sharedInstance.currentUser != nil) {
        
            if (type == "Webinars") {
            
        
                
                UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] = true;
           
            
            }
        
            else  {
            
    
                UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] = true
            }
            
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("info.txt")
            NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
            
        }
        
        else {
            
            if (type == "Webinars") {
                
                
                
                UserController.sharedInstance.tempWebinarFilters[indexPath.row] = true;
                
                
            }
                
            else  {
                
                
                UserController.sharedInstance.tempArticleFilters[indexPath.row] = true
            }
            
            
            
        }
        

        
        print("Selected was presed")
        return
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        print("deselected is press")
        
        if (UserController.sharedInstance.currentUser != nil) {
        
            if (type == "Webinars") {
        
            
                UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] = false
            }
        
            else {
            
                
                UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] = false
            }
            
            // this can be a performance issue
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("info.txt")
            NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
            
        }
        
        else {
            
            if (type == "Webinars") {
                
                
                UserController.sharedInstance.tempWebinarFilters[indexPath.row] = false
            }
                
            else {
                
                
                UserController.sharedInstance.tempArticleFilters[indexPath.row] = false
            }
            
            
        }
        

        
        return
    }
 
    
    
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55;
    }

    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
