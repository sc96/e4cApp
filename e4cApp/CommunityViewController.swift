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
    
    var projectsArray : [Project] = []
    
    var peopleArray : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Community"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

        
        self.navigationController?.navigationBar.barTintColor = UIColor.e4cLightBlue
        
        searchBar.delegate = self
        
        
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "User-50.png"),  style: .plain,  target: self, action: #selector(profileAction))
        
        navigationItem.rightBarButtonItem = filter_button
        
        addLeftBarButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "projectCell")
        tableView.register(UINib(nibName: "EngineersTableViewCell", bundle: nil), forCellReuseIdentifier: "engineerCell")
        
        /*
        // temp stuff
        for i in 0...9 {
            
            let tempProject = Project(title: "title \(i)", projectDescript : "New project", id : "aa", nameAuthor : "bob", sector : "Energy", emailAuthor : "bleh")
            
            projectsArray.append(tempProject)
            
        }
        
        
        for i in 0...30 {
            
            let tempPerson  = User(email: "bob@gmail.com", professionalStatus: 1, affiliation: 1, expertise: 1, country: 2, ageRange: 1, gender: 2, id: "tempId")
            tempPerson.firstName = "Bob"
            tempPerson.lastName = "Mason"
            
            peopleArray.append(tempPerson)
            
        } */
        
        
        search(q: "", onCompletion: {resultsCount, error in
            
            
            
            if error == nil {
                
            
                
            }
                
            else {

            }
        })
        
        
        // segmentController.selectedSegmentIndex == 0 => Projects
        // segmentController.selectedSegmentIndex == 1 => Engineers
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let q = searchBar.text
        
        search(q: q!, onCompletion: {resultsCount, error in
            
            
            
            if error == nil {
                
                
                
            }
                
            else {
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (segmentController.selectedSegmentIndex) {
            
        case 0:
            return projectsArray.count
        break
        
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
            
        case 0:
            return 150
            break
            
        case 1:
            return 50
            break
        default:
            return 0
            break
            
        }
 
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        
        if (segmentController.selectedSegmentIndex == 0) {
            
            let cell:ProjectTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
            
         
                
          
            cell.titleLabel.text = projectsArray[indexPath.row].title
            cell.sectorLabel.text = projectsArray[indexPath.row].sector
            cell.textView.text = projectsArray[indexPath.row].projectDescript
        
            // cell.titleLabel.text = "Project \([indexPath.row])"
            
            // allow the textView to detect tap on its cell
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectAction))
            cell.textView.addGestureRecognizer(tap)
            cell.textView.tag = indexPath.row
            
            return cell
        }
        
        else {
            let cell:EngineersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "engineerCell") as! EngineersTableViewCell
            
            
            cell.nameLabel.text = peopleArray[indexPath.row].firstName + peopleArray[indexPath.row].lastName
            cell.countryLabel.text = "Country : \(peopleArray[indexPath.row].country)"
            return cell
      
            
        }
        
        
        
      
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
 
        
        switch (segmentController.selectedSegmentIndex) {
            
        case 0:
            let projectPageViewController = ProjectPageViewController(nibName: "ProjectPageViewController", bundle: nil)
            
            projectPageViewController.name = projectsArray[indexPath.row].nameAuthor
            projectPageViewController.sector = projectsArray[indexPath.row].sector
            projectPageViewController.projectDescript = projectsArray[indexPath.row].projectDescript
            projectPageViewController.projectTitle = projectsArray[indexPath.row].title
            projectPageViewController.email = projectsArray[indexPath.row].emailAuthor
            self.navigationController?.pushViewController(projectPageViewController, animated: true)
            break
            
        case 1:
            let peopleViewController = PeopleViewController(nibName: "PeopleViewController", bundle: nil)
            peopleViewController.about = peopleArray[indexPath.row].user_descript
            peopleViewController.name = peopleArray[indexPath.row].firstName
            peopleViewController.affiliation = peopleArray[indexPath.row].affiliation
            peopleViewController.country = peopleArray[indexPath.row].country
            peopleViewController.professional = peopleArray[indexPath.row].professionalStatus
            peopleViewController.email = peopleArray[indexPath.row].email
            
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
                
                
                print(responseCode)
                
            }
                
            else {
                print(responseCode)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        
        
        if segmentController.selectedSegmentIndex == 0 {
            
            let parameters = ["query" : q]
            
            let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/searchprojects", method: .post, parameters: parameters)
        
        
            WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
                print(responseCode)
            
                if (responseCode == 200) {
                
                
                    print(json)
                    
                    let numResults = json.count
                    // get 10 for now
                    self.projectsArray = []
                    
                    if numResults >= 1 {
                        
                        let minNum = max(9, numResults-1)
                
                        for i in 0...minNum {
                    
                            let title = json[i]["title"].rawString()!
                            let projectDescript = json[i]["description"].rawString()!
                            let id = json[i]["id"].rawString()!
                            let sector = json[i]["sector"].rawString()!
                            let authorName = json[i]["owner_name"].rawString()!
                            let authorEmail = json[i]["owner_email"].rawString()!
                    
                            let tempProject = Project(title : title, projectDescript : projectDescript, id : id, nameAuthor : authorName, sector: sector, emailAuthor : authorEmail)
                        
                        
                    
                            self.projectsArray.append(tempProject)
                            // self.articlesArray.append(tempArticle)
                            self.tableView.reloadData()
                        }
                    
                    
                    }
                    onCompletion(200,nil)
                
                
                }
                
                else {
                
                
                    let message = "error"
                    onCompletion(100, message)
                }
            
            })
        }
        
        else {
            
            let parameters = ["query" : q]
            
            let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/searchusers", method: .post, parameters: parameters)
            
            
            WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
                
                print(responseCode)
                
                if (responseCode == 200) {
                    
                    
                    print(json)
                    
                    self.peopleArray = []
                    
                    
                    let numResults = json.count
                    
                    if numResults >= 1 {
                    
                        let minNum = min(29, numResults-1)
                    
                        for i in 0...minNum {
                        
                            let user_email = json[i]["user_email"].rawString()!
                            let user_country = json[i]["user_country"].rawValue as! Int
                            let user_description = json[i]["user_description"].rawString()!
                            let user_affiliation = json[i]["user_affiliation"].rawValue as! Int
                            let user_profStatus = json[i]["user_profstatus"].rawValue as! Int
                            let user_name = json[i]["user_firstname"].rawString()! + json[i]["user_lastname"].rawString()!
                        
                        
                            let tempPerson = User(email: user_email, professionalStatus: user_profStatus, affiliation: user_affiliation, expertise: -1, country: user_country, ageRange: -1, gender: -1, id: "temp")
                            tempPerson.firstName = user_name
                        
                        
                            self.peopleArray.append(tempPerson)
                        // self.articlesArray.append(tempArticle)
                            self.tableView.reloadData()
                        
                        
                        }
                        
                        onCompletion(200,nil)
                    }
                    
                    
                    
                }
                    
                else {
                    
                    
                    let message = "error"
                    onCompletion(100, message)
                }
                
            })
            
            
        }
    }

    
    
    func profileAction(sender:UIBarButtonItem){
        
        
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(profileViewController, animated: false)
    }
    
    
    func addAction(sender:UIBarButtonItem){
        
        
        let addProjectViewController = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        self.navigationController?.pushViewController(addProjectViewController, animated: false)
        
        
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if (segmentController.selectedSegmentIndex == 1) {
            navigationItem.leftBarButtonItem = nil
        }
        
        else {
            addLeftBarButton()
        }
        tableView.reloadData()
    }
    
    
    func selectAction(sender : UITapGestureRecognizer) {
        
        
        self.tableView(self.tableView, didSelectRowAt: IndexPath(row: sender.view!.tag, section: 0))
        
    }
    
    
    func addLeftBarButton() {
        
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Add-50.png"),  style: .plain,  target: self, action: #selector(addAction))
        navigationItem.leftBarButtonItem = add_button
        
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
