//
//  WebinarPageViewController.swift
//  E4C_app
//
//  Created by Sam on 3/31/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class WebinarPageViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var sectorLabel: UILabel!
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    
    var videotitle : String?
    var videoUrl : String?
    var sector: String?
    var content : String?
    var webinarId : Int?
    var favorited : Bool = false
    var currWebinar : Webinar?
    var manager  = FileManager.default
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let add_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorites-50.png"),  style: .plain,  target: self, action: #selector(favoriteAction))
        navigationItem.rightBarButtonItem = add_button
        
        titleLabel.text = videotitle
        sectorLabel.text = sector
        
        webView.loadHTMLString(content!, baseURL: nil)
        
        currWebinar = Webinar(title: videotitle!, content: content!, id: webinarId!)
        currWebinar!.sector = sector!
        
        webView.loadHTMLString(content!, baseURL: nil)
        
        
        if (UserController.sharedInstance.currentUser != nil) {
            
            
            
            let numFav = (UserController.sharedInstance.currentUser!.favoritedWebinars).count
            print(numFav)
            
            if numFav >= 1 {
                
                for i in 0...numFav-1 {
                    
                    if UserController.sharedInstance.currentUser!.favoritedWebinars[i] == webinarId! {
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
        
        let parameters = ["webinarid" : webinarId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/favoritewebinarforuser", method: .post, parameters: parameters)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                self.favorited = true
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                
                UserController.sharedInstance.currentUser!.favoritedWebinars.append(self.currWebinar!.id)
                
                
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                var fileUrl = documents.appendingPathComponent("Webinar-\(self.currWebinar!.id)")
                NSKeyedArchiver.archiveRootObject(self.currWebinar!, toFile: fileUrl.path)
                
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
        
        
        let parameters = ["webinarid" : webinarId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/unfavoritewebinarforuser", method: .post, parameters: parameters)
        
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                
                self.favorited = false
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites-50")
                
                if let index = UserController.sharedInstance.currentUser!.favoritedWebinars.index(of: self.currWebinar!.id) {
                    
                    UserController.sharedInstance.currentUser!.favoritedWebinars.remove(at: index)
                    let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    var fileUrl = documents.appendingPathComponent("Webinar-\(self.currWebinar?.id)")
                    
                    
                    if self.manager.fileExists(atPath: fileUrl.path) {
                        
                        do {
                            try self.manager.removeItem(atPath: fileUrl.path)
                            
                        } catch let error as NSError {
                            
                            // print("Error \(error.domain)")
                            onCompletion(responseCode,"Successful call, but?")
                        }
                        
                    }
                    
                    onCompletion(responseCode,"Removed from favorites")
                    
                    
                    fileUrl = documents.appendingPathComponent("info.txt")
                    NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
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
