//
//  FavoritesViewController.swift
//  e4cApp
//
//  Created by Sam on 4/21/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    // data array for Webinars/Articles
    var articles  : [Article] = []
    var webinars : [Webinar] = []
    
    var manager = FileManager.default


    override func viewDidLoad() {
        super.viewDidLoad()

        // setting up tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        tableView.register(UINib(nibName: "WebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "webinarCell")
  
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (segmentController.selectedSegmentIndex) {
        
        // news articles
        case 0:
            return UserController.sharedInstance.currentUser!.favoritedArticles.count
            break
        // webinars
        case 1:
            return UserController.sharedInstance.currentUser!.favoritedWebinars.count
            break
        default:
            return 0
            break
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch (segmentController.selectedSegmentIndex) {
            
        case 0:
            return 200
            break
            
        case 1:
            return 120
            break
        default:
            return 0
            break
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // news articles
        if segmentController.selectedSegmentIndex == 0 {
            
            let cell:ArticleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
            
            

            let articleID = UserController.sharedInstance.currentUser!.favoritedArticles[indexPath.row]
            let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documents.appendingPathComponent("Article-\(articleID)")

            // get favorited article from phone's memory
            if let tempArticle = NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path) as? Article {
                
                tempArticle.id = articleID
                articles.append(tempArticle)
                cell.titleLabel.text  = tempArticle.title
            }
   

            
            return cell
        }
            // webinars
            else {
                
                let cell:WebinarTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "webinarCell") as! WebinarTableViewCell
                let webinarID = UserController.sharedInstance.currentUser!.favoritedWebinars[indexPath.row]
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileUrl = documents.appendingPathComponent("Webinar-\(webinarID)")
            
                // get favorited webinar from phone's memory
                if let tempWebinar = NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path) as? Webinar {
                
                tempWebinar.id = webinarID
                webinars.append(tempWebinar)
                cell.titleLabel.text  = tempWebinar.title
                print(tempWebinar.id)
                
            }
                return cell
                
                
            }


        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        // news articles
        if (segmentController.selectedSegmentIndex == 0) {
            
            let newPageViewController = NewsPageViewController(nibName: "NewsPageViewController", bundle: nil)
            
            // gets info from data array
            newPageViewController.articleTitle = articles[indexPath.row].title
            newPageViewController.articleId = articles[indexPath.row].id
            newPageViewController.sector = articles[indexPath.row].sector
            newPageViewController.content = articles[indexPath.row].content
            
            // navigate to NewsPageViewController
            self.navigationController?.pushViewController(newPageViewController, animated: true)
        }
            
        // webinars
        else {
            
            let webinarPageViewController = WebinarPageViewController(nibName: "WebinarPageViewController", bundle: nil)
            
            // gets info from data array
            webinarPageViewController.videotitle = webinars[indexPath.row].title
            webinarPageViewController.sector = webinars[indexPath.row].sector
            webinarPageViewController.webinarId = webinars[indexPath.row].id
            webinarPageViewController.content = webinars[indexPath.row].content
            
            // navigate to WebinarPageViewController
            self.navigationController?.pushViewController(webinarPageViewController, animated: true)
        }
        
        

        }

    
    // reloads tableView when segment changes
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
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
