
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
    
    
    var webinarsArray : [Webinar] = []
    
    var filters : [Bool] = [false, false, false, false, false, false, false, false, false]
    
    var refreshControl : UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Webinars"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "webinarCell")
        
        searchBar.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false;
        navigationController!.navigationBar.isTranslucent = true;
        
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter-50.png"),  style: .plain,  target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter_button
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        
        if (searchBar.text != nil) {
            searchBarSearchButtonClicked(searchBar)
        }
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return webinarsArray.count;

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "webinarCell") as! WebinarTableViewCell
        
        let cell:WebinarTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "webinarCell") as! WebinarTableViewCell
        
        cell.titleLabel.text = webinarsArray[indexPath.row].title

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let webinarPageViewController = WebinarPageViewController(nibName: "WebinarPageViewController", bundle: nil)
        
        webinarPageViewController.videotitle = webinarsArray[indexPath.row].title
        webinarPageViewController.sector = webinarsArray[indexPath.row].sector
        webinarPageViewController.videoUrl = webinarsArray[indexPath.row].videoUrl
        webinarPageViewController.content = webinarsArray[indexPath.row].content
        webinarPageViewController.webinarId = webinarsArray[indexPath.row].id
        
        self.navigationController?.pushViewController(webinarPageViewController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func filterAction(sender:UIBarButtonItem){
        
        print("fake filtered")
        
        let filtersViewController = FiltersViewController(nibName: "FiltersViewController", bundle: nil)
        
        filtersViewController.type = "Webinars";
        
        self.navigationController?.present(filtersViewController, animated: false, completion: nil)
    }
    // call search function when the searchButtton is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        let q = searchBar.text
        
        search(q: q!, onCompletion: {responseCode, message in
            
            
            
            if message == nil {
                
                print(responseCode)
            }
                
            else {
                print(message!)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        if (UserController.sharedInstance.currentUser != nil) {
            
            parameters = ["query" : q, "sectors" : UserController.sharedInstance.currentUser?.webinarFilters]
            // parameters = ["sectors": [true, true, true, false, false, false, false, false, false]]
            
        }
            
        else {
            
            parameters = ["query" :q, "sectors" : UserController.sharedInstance.tempWebinarFilters]
            // parameters = ["sectors": [true, true, true, false, false, false, false, false, false]]
        }
        
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getwebinarsforsectors", method: .post, parameters: parameters)
        
     //   let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getallwebinars", method: .get, parameters: nil)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
            
                
                // print(json)
                self.webinarsArray = []
                let numResults = json.count
                if (numResults >= 1) {
                
                    
  
                    for i in 0...numResults-1 {
                    
                        let title = json[i]["post_title"].rawString()!
                        let postContent = json[i]["post_content"].rawString()!
                        let id = json[i]["id"].rawValue as! Int
                    
                        let tempWebinar = Webinar(title: title, content : postContent, id : id)
                        tempWebinar.sector = "Sector \(i)"
                        tempWebinar.videoUrl = "www.google.com"
                    
                    
                        self.webinarsArray.append(tempWebinar)
                    
                    }
                    
                    self.tableView.reloadData()

                }
                
                onCompletion(200,nil)
                
            }
                
            else {
                
                
                let message = "error"
                onCompletion(100, message)
            }
            
        })
    }
    
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


