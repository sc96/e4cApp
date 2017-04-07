//
//  NewsViewController.swift
//  E4C_app
//
//  Created by Sam on 3/31/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var articlesArray : [Article] = []

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
        
        // dummy data for now
        for i in 0...9 {
            
            let tempArticle = Article(title: "title \(i)", sector: "sector \(i)", author: "author \(i)", date: "date \(i)", imageUrl: "videoUrl \(i)")
            
            articlesArray.append(tempArticle)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:ArticleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        cell.titleLabel.text = "News title \(indexPath) "
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let newsPageViewController = NewsPageViewController(nibName: "NewsPageViewController", bundle: nil)
        
        newsPageViewController.articletitle = articlesArray[indexPath.row].title
        newsPageViewController.author = articlesArray[indexPath.row].author
        newsPageViewController.sector = articlesArray[indexPath.row].sector
        newsPageViewController.date = articlesArray[indexPath.row].date
        newsPageViewController.imageUrl = articlesArray[indexPath.row].imageUrl
        
        self.navigationController?.pushViewController(newsPageViewController, animated: true)
        
        
        
    }

    
    func filterAction(sender:UIBarButtonItem){
        
        print("fake filtered")
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
