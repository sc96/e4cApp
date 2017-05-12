    //
//  NewsPageViewController.swift
//  E4C_app
//
//  Created by Sam on 4/5/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class NewsPageViewController: UIViewController, UIWebViewDelegate, UITabBarDelegate, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sectorLabel: UILabel!

    @IBOutlet weak var webView: UIWebView!
    
    
    var articleTitle : String?
    var imageUrl : String?
    var content : String?
    var sector: String?
    var articleId : Int?
    var favorited : Bool = false
    var id : Int?
    
    var manager  = FileManager.default
    
    var currArticle : Article?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set fields
        titleLabel.text = articleTitle!
        
        // set current news Article
        currArticle = Article(title: articleTitle!, content: content!, id: articleId!)
        webView.delegate = self
        
        
        // add Favorite Button
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorites-50.png"),  style: .bordered,  target: self, action: #selector(favoriteAction))
        navigationItem.rightBarButtonItem = add_button
    
        
        
        // load body
        let cssString = "<style> body { font-family: Helvetica; font-size: 12px} </style>" + content!
        webView.loadHTMLString(cssString, baseURL: nil)
        
        // If we're logged in, check if favorited
        checkForFavorites();
        
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkForFavorites() {
        
        // check if we're logged in
        if (UserController.sharedInstance.currentUser != nil) {
            
            
            
            let numFav = (UserController.sharedInstance.currentUser!.favoritedArticles).count
            
            
            // check if this current news article is favoried
            if numFav >= 1 {
                
                for i in 0...numFav-1 {
                    
                    // if it is, we're just changing the picture of the favorited icon
                    if UserController.sharedInstance.currentUser!.favoritedArticles[i] == articleId! {
                        navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                        favorited = true
                        break
                    }
                    
                }
            }
        }
        
        
    }
    
    
    // favoriting the current Article
    func addFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        
        // creating parameters
        let parameters = ["id" : articleId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/favoritearticleforuser", method: .post, parameters: parameters)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            // success
            if (responseCode == 200) {
                
                
                // set favorited to be true
                self.favorited = true
                
                // change the icon
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                
                
                // add to current user's list of favorited articles (array of ints)
                UserController.sharedInstance.currentUser!.favoritedArticles.append(self.currArticle!.id)
                
                // add favorited article to the phone's memory
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                var fileUrl = documents.appendingPathComponent("Article-\(self.currArticle!.id)")
                NSKeyedArchiver.archiveRootObject(self.currArticle!, toFile: fileUrl.path)
                
                
                // save the current user to the phone's memory
                fileUrl = documents.appendingPathComponent("info.txt")
                NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                
                
                onCompletion(responseCode, "Successfully Saved")
                
                
            }
                
            // not successful
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
            }
            
        })
        
        
        
    }
    
    // unfavoriting the current Article
    func removeFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        // creating parameters
        let parameters = ["id" : articleId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/unfavoritearticleforuser", method: .post, parameters: parameters)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            
            // success
            if (responseCode == 200) {
                
                // set favorited to be flse
                self.favorited = false
                
                // changing the favorite icon
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites-50")
                
                
                // remove it from CurrentUser's favorited Articles list (array of ints)
                if let index = UserController.sharedInstance.currentUser!.favoritedArticles.index(of: self.currArticle!.id) {
                    
                    UserController.sharedInstance.currentUser!.favoritedArticles.remove(at: index)
                    let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    var fileUrl = documents.appendingPathComponent("Article-\(self.currArticle?.id)")

                    // remove the Webinar from the phone's memory
                    if self.manager.fileExists(atPath: fileUrl.path) {
                        
                        do {
                            try self.manager.removeItem(atPath: fileUrl.path)
                            
                        } catch let error as NSError {
                            
                            // print("Error \(error.domain)")
                            // shouldn't reach here
                            onCompletion(responseCode,"Successful call, but?")
                        }
                        
                    }
                    
                      // also have save the updated CurrentUser to the phone's memory
                    fileUrl = documents.appendingPathComponent("info.txt")
                    NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                    onCompletion(responseCode,"Removed from favorites")
                }
                
                
                // shouldn't reach here
                onCompletion(responseCode,"Removed from favorites")
                
            }
                
            // unsuccessful
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
            }
            
        })
        
    }
    
    func favoriteAction(sender:UIBarButtonItem) {
        
        
        // check if user is logged in
        if (UserController.sharedInstance.currentUser == nil) {
            
            let alert = UIAlertController(title: "Error", message: "You must be logged in to favorite.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                
                return
            
            })
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
        else {
        
            // current article is already favorited so we're unfavoriting
            if favorited {
                
                removeFavorite(onCompletion: {responseCode, message in
                
                    print(responseCode)
                    
                })
                
            }
            
            // current article is not already favorited, so we're favoriting
            else {
                
                addFavorite(onCompletion: {responseCode, message in
                    
                    print(responseCode)
                    
                    
                })
                
            }
        
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

}
