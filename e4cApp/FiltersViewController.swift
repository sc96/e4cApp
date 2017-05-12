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
    
    // data array for filters
    var sectors : [String] = ["Featured", "Water", "Energy", "Health", "Housing", "Agriculture", "Sanitation", "ICT", "Transport"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = type
        
        // set up tableView
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
        
        // 9
        return sectors.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell:FiltersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "filtersCell") as! FiltersTableViewCell
        
        let sector = sectors[indexPath.row]
        
        cell.titleLabel.text = sector
        
        
        // switch images and backgroundColor
        switch sector {
            
            case "Water" :
                cell.imageLabel.image = UIImage(named: "water.png")
                cell.backgroundColor = UIColor.waterColor
            case "Energy" :
                cell.imageLabel.image = UIImage(named: "energy.png")
                cell.backgroundColor = UIColor.energyColor
            case "Health" :
                cell.imageLabel.image = UIImage(named: "health.png")
                cell.backgroundColor = UIColor.healthColor
            case "Housing" :
                cell.imageLabel.image = UIImage(named: "housing.png")
                cell.backgroundColor = UIColor.housingColor
            case "Agriculture" :
                cell.imageLabel.image = UIImage(named: "agriculture.png")
                cell.backgroundColor = UIColor.agricultureColor
            case "Sanitation" :
                cell.imageLabel.image = UIImage(named: "sanitation.png")
                cell.backgroundColor = UIColor.sanitationColor
            case "ICT" :
                cell.imageLabel.image = UIImage(named: "ict.png")
                cell.backgroundColor = UIColor.ICTColor
            case "Transport" :
                cell.imageLabel.image = UIImage(named: "transport.png")
                cell.backgroundColor = UIColor.transportColor
            default:
                cell.imageLabel.image = nil
                cell.backgroundColor = UIColor.white
            
            
        }
        
        // some cell settings
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        
        
        
        // user is logged in
        if (UserController.sharedInstance.currentUser != nil) {
        
            // we look at the user's webinar filter array
            if (type == "Webinars") {
        
       
            // false
            if (UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] == false) {
                cell.accessoryType = .none
                
            }
            
            // true
            else {
                cell.accessoryType = .checkmark
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
        }
            // we look at the user's news articles filter array
            else {
            
        
                // false
                if (UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] == false) {
                cell.accessoryType = .none
                
                }
                
                // true
                else {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
        }
        
            
        // the user it not logged in, so we're looking at the tempFilter arrays
        else {
            
            // we look at tempWebinarFilters
            if (type == "Webinars") {
                
                
                // false
                if (UserController.sharedInstance.tempWebinarFilters[indexPath.row] == false) {
                    cell.accessoryType = .none
                    
                }
                
                // true
                else {
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
              
            // we look at tempArticlesFilters
            else {
                
                
                // false
                if (UserController.sharedInstance.tempArticleFilters[indexPath.row] == false) {
                    cell.accessoryType = .none
                    
                }
                    
                    
                // true
                else {
                    
                    cell.accessoryType = .checkmark
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                }
            }
            
        }
     
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        // user is logged in
        if (UserController.sharedInstance.currentUser != nil) {
        
            
            // webinars
            if (type == "Webinars") {
            
        
                
                UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] = true;
           
            
            }
        
                
            // news articles
            else  {
            
    
                UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] = true
            }
            
            // we save the filters to the phone's memory
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("info.txt")
            NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
            
        }
        
            
        // user is not logged in
        else {
            
            // webinars
            if (type == "Webinars") {
                
                
                
                UserController.sharedInstance.tempWebinarFilters[indexPath.row] = true;
                
                
            }
                
            // news articles
            else  {
                
                
                UserController.sharedInstance.tempArticleFilters[indexPath.row] = true
            }
            
            
            
        }
        


        return
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        
        // current user is logged in
        if (UserController.sharedInstance.currentUser != nil) {
        
            // webinars
            if (type == "Webinars") {
        
            
                UserController.sharedInstance.currentUser?.webinarFilters[indexPath.row] = false
            }
        
            // news articles
            else {
            
                
                UserController.sharedInstance.currentUser?.articleFilters[indexPath.row] = false
            }
            
            // save current filter options to phone's memory
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("info.txt")
            NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
            
        }
        
            
        // current user is not logged in
        else {
            
            // webinars
            if (type == "Webinars") {
                
                
                UserController.sharedInstance.tempWebinarFilters[indexPath.row] = false
            }
              
                
            // news articles
            else {
                
                
                UserController.sharedInstance.tempArticleFilters[indexPath.row] = false
            }
            
            
        }
        

        
        return
    }
 
    
    
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55;
    }

    
    // dismiss the modal presentation
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
