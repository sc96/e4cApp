
//
//  WebinarViewController.swift
//  
//
//  Created by Sam on 3/31/17.
//
//

import UIKit

class WebinarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // data Array for Webinars
    var webinarsArray : [Webinar] = []
    
    var refreshControl : UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup
        self.navigationItem.title = "Webinars"
        self.automaticallyAdjustsScrollViewInsets = false
        navigationController!.navigationBar.isTranslucent = true
        
        // tableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "webinarCell")
        
        
        // setting searchBar delegate
        searchBar.delegate = self
        

        // adding Filter Button to the navBar
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter-50.png"),  style: .plain,  target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter_button
        
        
        // setting refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        // Do an initial search to populate tableView
        if (searchBar.text != nil) {
            searchBarSearchButtonClicked(searchBar)
        }
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // refresh the data each time the View appears
    override func viewDidAppear(_ animated: Bool) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return webinarsArray.count;

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let cell:WebinarTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "webinarCell") as! WebinarTableViewCell
        
        // set cell's info
        cell.titleLabel.text = webinarsArray[indexPath.row].title

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let webinarPageViewController = WebinarPageViewController(nibName: "WebinarPageViewController", bundle: nil)
        
        // passing info to the next ViewController
        webinarPageViewController.videotitle = webinarsArray[indexPath.row].title
        webinarPageViewController.sector = webinarsArray[indexPath.row].sector
        webinarPageViewController.videoUrl = webinarsArray[indexPath.row].videoUrl
        webinarPageViewController.content = webinarsArray[indexPath.row].content
        webinarPageViewController.webinarId = webinarsArray[indexPath.row].id
        
        // navigating to WebinarPageViewController
        self.navigationController?.pushViewController(webinarPageViewController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250;
    }
    
    
    // navigate to FiltersViewController
    func filterAction(sender:UIBarButtonItem){
        
        
        let filtersViewController = FiltersViewController(nibName: "FiltersViewController", bundle: nil)
        filtersViewController.type = "Webinars";
        self.navigationController?.present(filtersViewController, animated: false, completion: nil)
        
    }
    
    
    // call search function when the searchButtton is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        let q = searchBar.text
        
        search(q: q!, onCompletion: {responseCode, message in
            
            
            // successful
            if message == nil {
                
                print(responseCode)
            }
               
            // not successful
            else {
                print(message!)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        
        // If we're logged in, use the currentUser's filters arrays
        // If we're not, we use the tempFilter Array (the filters array for non-logged users)
        if (UserController.sharedInstance.currentUser != nil) {
            
            parameters = ["query" : q, "sectors" : UserController.sharedInstance.currentUser?.webinarFilters]
            
        }
            
        else {
            
            parameters = ["query" :q, "sectors" : UserController.sharedInstance.tempWebinarFilters]
          
        }
        
        
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getwebinarsforsectors", method: .post, parameters: parameters)
        
     //   let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getallwebinars", method: .get, parameters: nil)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            
            // successful
            if (responseCode == 200) {
                
            
                
                // resetting webinarArrays before populating it
                self.webinarsArray = []
                let numResults = json.count
                
                if (numResults >= 1) {
                
  
                    for i in 0...numResults-1 {
                    
                        
                        // creatin Webinar object
                        let title = json[i]["post_title"].rawString()!
                        let postContent = json[i]["post_content"].rawString()!
                        let id = json[i]["id"].rawValue as! Int
                    
                        let tempWebinar = Webinar(title: title, content : postContent, id : id)
                        
                        // these two are dummy data
                        tempWebinar.sector = "Sector \(i)"
                        tempWebinar.videoUrl = "www.google.com"
                    
                        
                        // append to webinarArrays
                        self.webinarsArray.append(tempWebinar)
                    
                    }

                }
                
                // refresh tableView
                self.tableView.reloadData()
                onCompletion(responseCode,nil)
                
            }
              
                
            // not successful
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
            }
            
        })
    }
    
    
    // refresh the tableView (do a new search) when the refreshControl is activated
    func refreshTable() {
        
        searchBarSearchButtonClicked(searchBar)
        refreshControl.endRefreshing()
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


