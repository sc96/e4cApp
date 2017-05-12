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
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // setup
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        self.navigationItem.title = "Who We Are"
        

        // Rendering the 'Our Manifesto" video
        webView.loadHTMLString("<p style=\"text-align: center;\"><a target=\"_blank\" href=\"https://www.youtube.com/embed/SClOE9eCF3I?ecver=1\"><img src=\"https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto.jpg\" alt=\"ourmanifesto\" class=\"aligncenter size-full wp-image-10090\" srcset=\"https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto.jpg 993w, https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto-300x178.jpg 300w\" sizes=\"(max-width: 993px) 100vw, 993px\"></a></p>", baseURL: nil)
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
