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
    
    var filters : [Bool] = [false, false, false, false, false, false, false, false, false]
    
    var articlesArray : [Article] = []
    
    var refreshControl: UIRefreshControl!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "News"
        
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter-50.png"),  style: .plain,  target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter_button
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        searchBar.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Release to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        // dummy data for now
        
        /*
        
        for i in 0...9 {
            
            let tempArticle = Article(title: "title \(i)", content : "content \(i)", id : -1)
            
            articlesArray.append(tempArticle)
            
        } */
 
        
        
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
        
        return articlesArray.count;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:ArticleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        
        
        cell.titleLabel.text = articlesArray[indexPath.row].title

    
     
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let newsPageViewController = NewsPageViewController(nibName: "NewsPageViewController", bundle: nil)
        
        newsPageViewController.articleTitle = articlesArray[indexPath.row].title
        newsPageViewController.sector = articlesArray[indexPath.row].sector
        newsPageViewController.imageUrl = articlesArray[indexPath.row].imageUrl
        newsPageViewController.content = articlesArray[indexPath.row].content
        newsPageViewController.articleId = articlesArray[indexPath.row].id
        
        self.navigationController?.pushViewController(newsPageViewController, animated: true)
        
        
        
    }

    
    func filterAction(sender:UIBarButtonItem){
        
        print("fake filtered")
        let filtersViewController = FiltersViewController(nibName: "FiltersViewController", bundle: nil)
        
        filtersViewController.type = "News";
        
        self.navigationController?.present(filtersViewController, animated: false, completion: nil)
    }
    
    
    func selectAction(sender : UITapGestureRecognizer) {
        
        
        self.tableView(self.tableView, didSelectRowAt: IndexPath(row: sender.view!.tag, section: 0))
        
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
                print(error!)
            }
        })
        
    }
    
    
    // search for items via keywords
    func search(q: String, onCompletion: @escaping (Int?, String?) -> Void) {
        
        var parameters : [String :Any]
        
        
        
        if (UserController.sharedInstance.currentUser != nil) {
            
            parameters = ["query" :q, "sectors" : UserController.sharedInstance.currentUser?.articleFilters]
            
        }
        
        else {
            
            parameters = ["query" : q, "sectors" : UserController.sharedInstance.tempArticleFilters]
        }

 
        
        
        
   //     let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/searchnews", method: .post, parameters: parameters)
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getnewsforsectors", method: .post, parameters: parameters)
        
    //    let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/getallnews", method: .get, parameters: nil)
        
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
           //     print(json)
                
                self.articlesArray = []
                
                let numResults = json.count
                if (numResults >= 1) {
                    
                    
  
                    for i in 0...numResults-1 {
                    
                        let title = json[i]["post_title"].rawString()!
                        let postContent = json[i]["post_content"].rawString()!
                        let id = json[i]["id"].rawValue as! Int
                    //    let sector = json[i]["sectors"][0].rawString()!
                    
                        let tempArticle = Article(title: title, content : postContent, id : id)
                        tempArticle.sector = "sector"
                        tempArticle.imageUrl = "www.google.com"
                    
                        self.articlesArray.append(tempArticle)

                    }
                    
                  
                    self.tableView.reloadData()
                }
                
                    
                    
                onCompletion(responseCode,nil)
            }
            
                
                
                
            
            
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
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

