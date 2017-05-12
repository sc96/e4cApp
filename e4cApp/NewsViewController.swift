//
//  NewsViewController.swift
//  E4C_app
//
//  Created by Sam on 3/31/17.
//  Copyright © 2017 Sam. All rights reserved.
//

// Free icons used from:  https://icons8.com/



import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    // data Array for Webinars
    var articlesArray : [Article] = []
    
    
    // refreshControl
    var refreshControl: UIRefreshControl!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup
        self.navigationItem.title = "News"
        self.automaticallyAdjustsScrollViewInsets = false
        navigationController!.navigationBar.isTranslucent = true
        
        // adding Filter button to navBar
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter-50.png"),  style: .plain,  target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter_button
        
        
        // tableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        
        // setting searchBar delegate
        searchBar.delegate = self
        
        
        // refreshControl setup
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
        
        return articlesArray.count;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:ArticleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        
        // setting cell's info
        cell.titleLabel.text = articlesArray[indexPath.row].title
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let newsPageViewController = NewsPageViewController(nibName: "NewsPageViewController", bundle: nil)
        
        
        // passing info to the next ViewController
        newsPageViewController.articleTitle = articlesArray[indexPath.row].title
        newsPageViewController.sector = articlesArray[indexPath.row].sector
        newsPageViewController.imageUrl = articlesArray[indexPath.row].imageUrl
        newsPageViewController.content = articlesArray[indexPath.row].content
        newsPageViewController.articleId = articlesArray[indexPath.row].id
        
        
        // navigating to WebinarPageViewController
        self.navigationController?.pushViewController(newsPageViewController, animated: true)
        
        
        
    }

    // navigate to FiltersViewController
    func filterAction(sender:UIBarButtonItem){
        
        let filtersViewController = FiltersViewController(nibName: "FiltersViewController", bundle: nil)
        
        filtersViewController.type = "News";
        
        self.navigationController?.present(filtersViewController, animated: false, completion: nil)
    }
    
    
    
    // call search function when the searchButtton is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        let q = searchBar.text
        
        search(q: q!, onCompletion: {responseCode, error in
            
            
            // successful
            if error == nil {
                
                print(responseCode)
                
            }
               
            // not successful
            else {
                print(error!)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        
        // If we're logged in, use the currentUser's filters arrays
        // If we're not, we use the tempFilter Array (the filters array for non-logged users)
        if (UserController.sharedInstance.currentUser != nil) {
            
            parameters = ["query" :q, "sectors" : UserController.sharedInstance.currentUser?.articleFilters]
            
        }
        
        else {
            
            parameters = ["query" : q, "sectors" : UserController.sharedInstance.tempArticleFilters]
        }

 
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getnewsforsectors", method: .post, parameters: parameters)

        
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            
            // success
            if (responseCode == 200) {
                

                // reset articlesArray before populating it
                self.articlesArray = []
                
                let numResults = json.count
                
                if (numResults >= 1) {
                    
                    
  
                    for i in 0...numResults-1 {
                    
                        // get info from JSON
                        let title = json[i]["post_title"].rawString()!
                        let postContent = json[i]["post_content"].rawString()!
                        let id = json[i]["id"].rawValue as! Int
                    
                        // create Article
                        let tempArticle = Article(title: title, content : postContent, id : id)
                        
                        // dummy info
                        tempArticle.sector = "sector"
                        tempArticle.imageUrl = "www.google.com"
                    
                        // append to articlesArray
                        self.articlesArray.append(tempArticle)

                    }
                    
                }
                
                // reload tableView with new data
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

