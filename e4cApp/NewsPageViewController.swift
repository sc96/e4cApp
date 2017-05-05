    //
//  NewsPageViewController.swift
//  E4C_app
//
//  Created by Sam on 4/5/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class NewsPageViewController: UIViewController {
    
    
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
        
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorites-50.png"),  style: .bordered,  target: self, action: #selector(favoriteAction))
        navigationItem.rightBarButtonItem = add_button
        
        titleLabel.text = articleTitle!
        
        
        currArticle = Article(title: articleTitle!, content: content!, id: articleId!)
        
        webView.loadHTMLString(content!, baseURL: nil)
        
        if (UserController.sharedInstance.currentUser != nil) {
            
          
            
            let numFav = (UserController.sharedInstance.currentUser!.favoritedArticles).count
            print(numFav)
            
            if numFav >= 1 {
            
                for i in 0...numFav-1 {
                
                    if UserController.sharedInstance.currentUser!.favoritedArticles[i] == articleId! {
                        navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                        favorited = true
                        break
                    }
                
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        let parameters = ["articleid" : articleId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/favoritearticleforuser", method: .post, parameters: parameters)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                self.favorited = true
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                
                UserController.sharedInstance.currentUser!.favoritedArticles.append(self.currArticle!.id)
                
                
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                var fileUrl = documents.appendingPathComponent("Article-\(self.currArticle!.id)")
                NSKeyedArchiver.archiveRootObject(self.currArticle!, toFile: fileUrl.path)
                
                fileUrl = documents.appendingPathComponent("info.txt")
                NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                onCompletion(responseCode, "Successfully Saved")
                
                
            }
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
            }
            
        })
        
        
        
    }
    
    
    func removeFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        
        let parameters = ["articleid" : articleId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/unfavoritearticleforuser", method: .post, parameters: parameters)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                
                self.favorited = false
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites-50")
                
                if let index = UserController.sharedInstance.currentUser!.favoritedArticles.index(of: self.currArticle!.id) {
                    
                    UserController.sharedInstance.currentUser!.favoritedArticles.remove(at: index)
                    let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    var fileUrl = documents.appendingPathComponent("Article-\(self.currArticle?.id)")

                    
                    if self.manager.fileExists(atPath: fileUrl.path) {
                        
                        do {
                            try self.manager.removeItem(atPath: fileUrl.path)
                            
                        } catch let error as NSError {
                            
                            // print("Error \(error.domain)")
                            onCompletion(responseCode,"Successful call, but?")
                        }
                        
                    }
                    
                    fileUrl = documents.appendingPathComponent("info.txt")
                    NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                    
                    
                    onCompletion(responseCode,"Removed from favorites")
                }
                
                onCompletion(responseCode,"Removed from favorites")
                
            }
            else {
                
                
                let message = "error"
                onCompletion(responseCode, message)
            }
            
        })
        
    }
    
    func favoriteAction(sender:UIBarButtonItem) {
        
        if (UserController.sharedInstance.currentUser == nil) {
            
            let alert = UIAlertController(title: "Error", message: "You must be logged in to favorite.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                
                return
            
            })
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
        else {
        
            if favorited {
                
                removeFavorite(onCompletion: {responseCode, message in
                
                    print(responseCode)
                    
                })
                
            }
            
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
