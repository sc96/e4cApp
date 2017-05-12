//
//  CommunityViewController.swift
//  E4C_app
//
//  Created by Sam on 3/31/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    // Data Arrays for the tableViews
    var projectsArray : [Project] = []
    var peopleArray : [User] = []
    
    
    // refreshControl
    var refreshControl : UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup
        self.navigationItem.title = "Community"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.e4cLightBlue
        
        
        // setting searchBar Delegat
        searchBar.delegate = self
        
        // Adding Filter_Button to the NavBar
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "User-50.png"),  style: .plain,  target: self, action: #selector(profileAction))
        navigationItem.rightBarButtonItem = filter_button
        addLeftBarButton()
        
        
        
        // tableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "projectCell")
        tableView.register(UINib(nibName: "EngineersTableViewCell", bundle: nil), forCellReuseIdentifier: "engineerCell")
        
        
        // Setting the refreshControl.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        
        // do the first search when the ViewController loads to popular the data array
        search(q: "", onCompletion: {responseCode, error in
            
            // no error
            if error == nil {

                
            }
                
                
            // error
            else {
                
                print(responseCode)
                

            }
        })
        
        
    
    }
    
    // refresh the data each time the View appears
    override func viewDidAppear(_ animated: Bool) {
        
        let q = searchBar.text
        
        search(q: q!, onCompletion: {responseCode, error in
            
            
            // no error
            if error == nil {
                
                
                
            }
              
            // an error
            else {
                print(responseCode)
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (segmentController.selectedSegmentIndex) {
            
            
        // Projects
        case 0:
            return projectsArray.count
        break
        
        // People
        case 1:
            return peopleArray.count
        break
        default:
            return 0
        break
            
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch (segmentController.selectedSegmentIndex) {
        
        // Projects
        case 0:
            return 150
            break
        // People
        case 1:
            return 50
            break
        default:
            return 0
            break
            
        }
 
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        // Projects
        if (segmentController.selectedSegmentIndex == 0) {
            
            let cell:ProjectTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
            
         
                
            // setting Cell Info
            cell.titleLabel.text = projectsArray[indexPath.row].title
            cell.sectorLabel.text = projectsArray[indexPath.row].sector
            cell.textView.text = projectsArray[indexPath.row].projectDescript
        
            
            
            // tapAction to allow cell selection when pressing on the cell's textView
            // Otherwise, pressing on the cell's textView (description) doesn't call didSelectRow
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectAction))
            cell.textView.addGestureRecognizer(tap)
            cell.textView.tag = indexPath.row
            
            return cell
        }
        
            
        // People
        else {
            let cell:EngineersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "engineerCell") as! EngineersTableViewCell
            
            // setting cell's info
            cell.nameLabel.text = peopleArray[indexPath.row].firstName + peopleArray[indexPath.row].lastName
            cell.countryLabel.text = "Country : \(peopleArray[indexPath.row].country)"
            return cell
      
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
 
        
        switch (segmentController.selectedSegmentIndex) {
           
        // Projects
        case 0:
            let projectPageViewController = ProjectPageViewController(nibName: "ProjectPageViewController", bundle: nil)
            
            
            // passing info to the next ViewVontroller
            projectPageViewController.name = projectsArray[indexPath.row].nameAuthor
            projectPageViewController.sector = projectsArray[indexPath.row].sector
            projectPageViewController.projectDescript = projectsArray[indexPath.row].projectDescript
            projectPageViewController.projectTitle = projectsArray[indexPath.row].title
            projectPageViewController.email = projectsArray[indexPath.row].emailAuthor
            
            // Navigating to projectsPageViewController
            self.navigationController?.pushViewController(projectPageViewController, animated: true)
            break
        
        // People
        case 1:
            let peopleViewController = PeopleViewController(nibName: "PeopleViewController", bundle: nil)
            
            // passing info to the next ViewController
            peopleViewController.about = peopleArray[indexPath.row].user_descript
            peopleViewController.name = peopleArray[indexPath.row].firstName
            peopleViewController.affiliation = peopleArray[indexPath.row].affiliation
            peopleViewController.country = peopleArray[indexPath.row].country
            peopleViewController.professional = peopleArray[indexPath.row].professionalStatus
            peopleViewController.email = peopleArray[indexPath.row].email
            
            // Navigating to peopleViewController
            self.navigationController?.pushViewController(peopleViewController, animated: true)
            break
        default:
            break
            
        }
        
        
    }
    
    // call search function when the searchButtton is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        let q = searchBar.text
        
        search(q: q!, onCompletion: {responseCode, error in
            
            
            if error == nil {
                
                
            }
                
            else {
                print(responseCode)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        
        // searching for projects
        if segmentController.selectedSegmentIndex == 0 {
            
            
            // creating parameter
            let parameters = ["query" : q]
            
            
            // creating request
            let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/searchprojects", method: .post, parameters: parameters)
        
            // executing request
            WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
                print(responseCode)
            
                // success
                if (responseCode == 200) {
                
                
                    
                    let numResults = json.count
                    
                    // reset ProjectArrays before populating it
                    self.projectsArray = []
                    
                    // We got result back.
                    if numResults >= 1 {
                        
                
                        // for each project
                        for i in 0...numResults-1 {
                    
                            
                            let title = json[i]["title"].rawString()!
                            let projectDescript = json[i]["description"].rawString()!
                            let id = json[i]["id"].rawString()!
                            let sector = json[i]["sector"].rawString()!
                            let authorName = json[i]["owner_name"].rawString()!
                            let authorEmail = json[i]["owner_email"].rawString()!
                    
                            
                            // create project object
                            let tempProject = Project(title : title, projectDescript : projectDescript, id : id, nameAuthor : authorName, sector: sector, emailAuthor : authorEmail)
                        
                        
                            // add to the projects Array
                            self.projectsArray.append(tempProject)
                        }
                    
                    
                    }
                    
                    // reload the tableView to show new data
                    self.tableView.reloadData()
                    onCompletion(responseCode,nil)
                
                
                }
                // error
                else {
                
                
                    let message = "error"
                    onCompletion(responseCode, message)
                }
            
            })
        }
        
            
        // searching for people
        else {
            
            // creating parameter
            let parameters = ["query" : q]
            
            
            // creating request
            let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/searchusers", method: .post, parameters: parameters)
            
            // executing request
            WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
                
                print(responseCode)
                
                
                // request was successful
                if (responseCode == 200) {
                    

                    // resetting peopleArray before populating it
                    self.peopleArray = []
                    
                    let numResults = json.count
                    
                    if numResults >= 1 {
                    
          
                    
                        for i in 0...numResults-1 {
                        
                            // create a tempPerson
                            let user_email = json[i]["user_email"].rawString()!
                            let user_country = json[i]["user_country"].rawValue as! Int
                            let user_description = json[i]["user_description"].rawString()!
                            let user_affiliation = json[i]["user_affiliation"].rawValue as! Int
                            let user_profStatus = json[i]["user_profstatus"].rawValue as! Int
                            let user_name = json[i]["user_firstname"].rawString()! + json[i]["user_lastname"].rawString()!
                        
                            // some details such as id and ageRange aren't shown to others
                            // so we can set the to anything
                            let tempPerson = User(email: user_email, professionalStatus: user_profStatus, affiliation: user_affiliation, expertise: -1, country: user_country, ageRange: -1, gender: -1, id: "temp")
                            
                            tempPerson.firstName = user_name
                        
                            // add to peopleArrays
                            self.peopleArray.append(tempPerson)
                            self.tableView.reloadData()
                        
                        
                        }
                        
                        onCompletion(responseCode,nil)
                    }
                    
                    
                    
                }
                    
                // not successful
                else {
                    
                    let message = "error"
                    onCompletion(responseCode, message)
                }
                
            })
            
            
        }
    }

    // navigate to ProfileViewController
    func profileAction(sender:UIBarButtonItem){
        

        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(profileViewController, animated: false)
    }
    
    
    
    // navigate to AddProjectViewController
    func addAction(sender:UIBarButtonItem){
        
        
        let addProjectViewController = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        self.navigationController?.pushViewController(addProjectViewController, animated: false)
        
        
    }


    // Only show the AddProject button when segmentController == 0 (searching/viewing Projects)
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if (segmentController.selectedSegmentIndex == 1) {
            navigationItem.leftBarButtonItem = nil
        }
        
        else {
            addLeftBarButton()
        }
        tableView.reloadData()
    }
    

    // calls didSelectRow when the cell's textView was pressed
    func selectAction(sender : UITapGestureRecognizer) {

        self.tableView(self.tableView, didSelectRowAt: IndexPath(row: sender.view!.tag, section: 0))
        
    }
    
 
    // add the AddProject button to the NavBar
    func addLeftBarButton() {
        
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Add-50.png"),  style: .plain,  target: self, action: #selector(addAction))
        navigationItem.leftBarButtonItem = add_button
        
    }
    
    
    
    // refresh the tableView (do a new search) when the refreshControl is activated
    func refreshTable() {
        
        searchBarSearchButtonClicked(searchBar)
        refreshControl.endRefreshing()
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
