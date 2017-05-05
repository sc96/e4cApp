//
//  AboutUsViewController.swift
//  e4cApp
//
//  Created by Sam on 4/6/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        webView.loadHTMLString("<iframe width=\"280\" height=\"180\" src=\"https://www.youtube.com/embed/SClOE9eCF3I?ecver=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
