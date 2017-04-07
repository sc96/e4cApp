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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Webinars"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WebinarTableViewCell", bundle: nil), forCellReuseIdentifier: "webinarCell")
        
        
        self.automaticallyAdjustsScrollViewInsets = false;
        navigationController!.navigationBar.isTranslucent = true;
        
        let filter_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter-50.png"),  style: .plain,  target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter_button
        
        // dummy data for now
        for i in 0...9 {
            
            let tempWebinar = Webinar(title: "title \(i)", sector: "sector \(i)", author: "author \(i)", date: "date \(i)", videoUrl: "videoUrl \(i)")
            
            webinarsArray.append(tempWebinar)
            
        }
        
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10;

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "webinarCell") as! WebinarTableViewCell
        
        let cell:WebinarTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "webinarCell") as! WebinarTableViewCell
        
        cell.titleLabel.text = "Webinar title \(indexPath) "
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let webinarPageViewController = WebinarPageViewController(nibName: "WebinarPageViewController", bundle: nil)
        
        webinarPageViewController.videotitle = webinarsArray[indexPath.row].title
        webinarPageViewController.author = webinarsArray[indexPath.row].author
        webinarPageViewController.sector = webinarsArray[indexPath.row].sector
        webinarPageViewController.date = webinarsArray[indexPath.row].date
        webinarPageViewController.videoUrl = webinarsArray[indexPath.row].videoUrl
        
        self.navigationController?.pushViewController(webinarPageViewController, animated: true)
        
        
        
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
