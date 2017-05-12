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
        
        
        // set fields
        titleLabel.text = videotitle
        
        // set Current Webinar
        currWebinar = Webinar(title: videotitle!, content: content!, id: webinarId!)
        currWebinar!.sector = sector!
        
        // load body of webnar
        let cssString = "<style> body { font-family: Helvetica; font-size: 12px} </style>" + content!
        webView.loadHTMLString(cssString, baseURL: nil)
        
        // If we're logged in, check for favorites
        if (UserController.sharedInstance.currentUser != nil) {
            
            
            let numFav = (UserController.sharedInstance.currentUser!.favoritedWebinars).count
            print(numFav)
            
            // we're just changing the picture of the favorite icon, if the webinar is favorited
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
    

    // favoriting the current Webinar
    func addFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        
        // creating parameter
        let parameters = ["id" : webinarId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/favoritewebinarforuser", method: .post, parameters: parameters)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            
            // success
            if (responseCode == 200) {
                
                // set favorited to true
                self.favorited = true
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites_Filled-50")
                
                
                // append the Webinar's ID to the currentUser's list of favorited Webinars (list of ints)
                UserController.sharedInstance.currentUser!.favoritedWebinars.append(self.currWebinar!.id)
                
                
                // save the Webinar's content to the phone's memory
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                var fileUrl = documents.appendingPathComponent("Webinar-\(self.currWebinar!.id)")
                NSKeyedArchiver.archiveRootObject(self.currWebinar!, toFile: fileUrl.path)
                
                
                // also have save the updated CurrentUser to the phone's memory
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
    
    // unfavoriting the current Webinar
    func removeFavorite(onCompletion: @escaping (Int?, String?) -> Void) {
        
        // creating parameter
        let parameters = ["id" : webinarId!, "userid" : UserController.sharedInstance.currentUser!.id] as [String : Any]
        
        
        // creating request
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/unfavoritewebinarforuser", method: .post, parameters: parameters)
        
        // executing request
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            // request was successful
            if (responseCode == 200) {
                
                // unfavorite the current Webinar
                self.favorited = false
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Favorites-50")
                
                
                // remove it from CurrentUSer's favorited Webinars list (array of ints)
                if let index = UserController.sharedInstance.currentUser!.favoritedWebinars.index(of: self.currWebinar!.id) {
                    
                    UserController.sharedInstance.currentUser!.favoritedWebinars.remove(at: index)
                    
                    // remove the Webinar from the phone's memory
                    let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    var fileUrl = documents.appendingPathComponent("Webinar-\(self.currWebinar?.id)")
                    
                    
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
                
                
                // shouldn't reach here.
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
           
        // user is logged in
        else {
            
            
            // Current webinar was already favorited, so we're unfavoriting
            if favorited {
                
                removeFavorite(onCompletion: {responseCode, message in
                    
                    print(responseCode)
                    
                })
                
            }
            
                
            // Current webinar was not already favorited , so we're favoriting
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
