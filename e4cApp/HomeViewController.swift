//
//  HomeViewController.swift
//  
//
//  Created by Sam on 3/31/17.
//
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sectorTableView: UITableView!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var youtubeButton: UIButton!
    
    
    @IBOutlet weak var aboutUsButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var eventTableView: UITableView!
    
    
    @IBOutlet weak var fbButton: UIButton!
    
    @IBOutlet weak var webView: UIWebView!
    

    
    
    
    // various hardcoded data arrays
    var eventDescription : [String] = ["May 25-May 25 ASME ISHOW 2017: Kenya Nairobi, 2nd floor, Bishop magua Cnetre, Ngong Road", "Jun 22 - Jun 22 ASME ISHOW 2017: USA Washington DC"]
    
    var sectors : [String] = ["Water", "Energy", "Health", "Housing", "Agriculture", "Sanitation", "ICT", "Transport"]
    
    // for now
    var sectorsInfo : [String] = ["Nearly 1 billion people don’t have access to clean water, and the consequences are fatal. Diarrhea is one of the leading killers of children under the age of five. Fortunately, the solutions needed to access clean water can be affordable and reliable. With informed design and management, drawing water, transporting and purifying it are all possible for everyone worldwide.", "When the sun goes down, the day ends. No work after dark, no studying. That’s the reality for one quarter of the world’s population that lives without electricity. Inventive design and the falling cost of solar power is lighting up homes that the traditional energy grid has left dark. Power solutions that can scale are filling in the grid gaps with solar, hydro, wind and biogas. With alternative energy solutions, the world is lighting up.", "Technology is essential to good health worldwide. Product designers are revealing its potential with devices such as paper-based rapid disease diagnostics, accurate male circumcision tools that can reduce the rate of HIV infection, and suites of telemedicine tools that put doctors on screens right in a patient’s home. Medical devices are the link between good design and good health.", "Informed construction saves lives, and it also just makes life more pleasant. Architects and engineers are mining the world’s traditional building techniques to find better ways to contend with earthquakes and floods and to adapt to problems like extreme weather in changing climates. At the same time, design of refugee housing and disaster-resistant buildings incorporates tried-and-tested construction with materials like reinforced cement and even plastic. Our basic human right to shelter increasingly hinges on smart choices and good design ", "870 million people worldwide are chronically undernourished. Irrigating crops is a simple solution that can double the amount of food a farm produces. But as much as 80 percent of farmland worldwide is not irrigated. Tested machines and new innovations meet that need and others on the farm. From pumps powered by diesel or the sun, drip tubes, mobile apps for weather and market information, low-cost utility vehicles, shellers, driers and much more, innovative design is putting more food on the world’s tables.", "About one in three people worldwide don’t have access to improved sanitation, but managing waste could solve a lot of the world’s health problems. For all of its importance, the issue still gets little attention. We have the solutions. Good, low-cost latrines have been built worldwide, latrines that do not require an expensive sewage system because they compost waste to convert it into safe fertilizer. The toilets of the world’s future might look reminiscent of the toilets of the past, and that’s a testament to user-centered design.", "The boom in mobile phone ownership has been one of the unanticipated success stories of global development. And with all of that computing power in the hands of so many people, software engineers are at the leading edge of the work to improve lives. Other electronic hardware is also gaining momentum, with innovations like e-readers, drones and 3D printers. These tools are how communities can leapfrog over phases of development to catch up with the pack.", "Bridges, boats and wheels are connecting people in inventive ways. Bicycle ambulances save lives in the world’s hard-to-reach communities, clinics on buses take medical care to the village, and farmers build do-it-yourself tractors and drive trucks that pull double duty as water pumps and crop processors. Drivers and riders are at the center of transport design in global development."]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Home"
        
        // setting up collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HotTopicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hotTopicCell")
        
        
        // setting up sectorTableView
        sectorTableView.delegate = self
        sectorTableView.dataSource = self
        sectorTableView.register(UINib(nibName: "SectorsTableViewCell", bundle: nil), forCellReuseIdentifier: "sectorCell")
        
        
        // setting up eventTableView
        eventTableView.delegate = self;
        eventTableView.dataSource = self;
        eventTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        
    
        

        // setting up webView
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        // load E4C's manifesto video
        webView.loadHTMLString("<p style=\"text-align: center;\"><a target=\"_blank\" href=\"https://www.youtube.com/embed/SClOE9eCF3I?ecver=1\"><img src=\"https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto.jpg\" alt=\"ourmanifesto\" class=\"aligncenter size-full wp-image-10090\" srcset=\"https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto.jpg 993w, https://www.engineeringforchange.org/wp-content/uploads/2015/07/ourmanifesto-300x178.jpg 300w\" sizes=\"(max-width: 993px) 100vw, 993px\"></a></p>", baseURL: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:HotTopicsCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "hotTopicCell", for: indexPath) as! HotTopicsCollectionViewCell
        
        // hardcoded images to look nice
        switch(indexPath.row) {
            
        case 0:
            cell.imageView.image = UIImage(named: "featuredNews1")
            break
        case 1:
            cell.imageView.image = UIImage(named: "featuredNews2")
            break
        case 2:
            cell.imageView.image = UIImage(named: "featuredNews3")
            break
        default:
            cell.imageView.image = UIImage(named: "featuredNews4")
            break
            
        }
        
        
        return cell;

        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // API doesn't support featured news so we're just linking to the E4C's homepage for now
        let url = URL(string: "https://www.engineeringforchange.org/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == sectorTableView) {
            return 8;
        }
        
        else {
            return 2;
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (tableView == sectorTableView) {
            return 150;
        }
        else {
            return 100;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (tableView == sectorTableView) {
            
            let cell:SectorsTableViewCell = self.sectorTableView.dequeueReusableCell(withIdentifier: "sectorCell") as! SectorsTableViewCell
            
            // get cell's info from data arrays
            cell.textView.text = sectorsInfo[indexPath.row]
            cell.titleLabel.text = sectors[indexPath.row]
            
            

            
            // allow the textView to detect tap on its cell
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectAction))
            cell.textView.addGestureRecognizer(tap)
            cell.textView.tag = indexPath.row
            
            
            let sector = sectors[indexPath.row]
            
            switch sector {
                
            // switching the cell's background color
            case "Water" :
                cell.backgroundColor = UIColor.waterColor
              
            case "Energy" :
                cell.backgroundColor = UIColor.energyColor
            case "Health" :
                cell.backgroundColor = UIColor.healthColor
            case "Housing" :
                cell.backgroundColor = UIColor.housingColor
            case "Agriculture" :
                cell.backgroundColor = UIColor.agricultureColor
            case "Sanitation" :
                cell.backgroundColor = UIColor.sanitationColor
            case "ICT" :
                cell.backgroundColor = UIColor.ICTColor
            case "Transport" :
                cell.backgroundColor = UIColor.transportColor
            default:
                cell.backgroundColor = UIColor.white
                
                
            }
            
            
            return cell
            
        }
        
        // EventTableView
        else {
            
            let cell:EventTableViewCell = self.eventTableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
            
            cell.titleLabel.text = eventDescription[indexPath.row]
            
            // hardcoded images
            if (indexPath.row == 1) {
                cell.imageView?.image = UIImage(named: "eventPlaceHolder2")
            }
            else {
                cell.imageView?.image = UIImage(named: "eventPlaceHolder1")
            }
            
            
            return cell
        }
        

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == sectorTableView) {
            
            // if current user is logged in
            if UserController.sharedInstance.currentUser != nil {
                
                // setting all the filters to be false except for the selected sector
                UserController.sharedInstance.currentUser!.articleFilters = [false, false, false, false, false, false, false, false, false]
                
                // we add 1 to the index because the filter array actually has 9 entries, "featured"
                // + the 8 sectors
                UserController.sharedInstance.currentUser!.articleFilters[indexPath.row+1] = true
            }
            
            // current user is not logged in, editing tempArticleFilters instead
            else {
                
                // setting all the filters to be false except for the selected sector
                UserController.sharedInstance.tempArticleFilters =  [false, false, false, false, false, false, false, false, false]
                
                // we add 1 to the index because the filter array actually has 9 entries, "featured"
                // + the 8 sectors
                UserController.sharedInstance.tempArticleFilters[indexPath.row+1] = true
                
            }
            
            //  navigates to NewsViewController
            let newsViewController = NewsViewController(nibName: "NewsViewController", bundle: nil)
            self.navigationController?.pushViewController(newsViewController, animated: true)
        }
        
        
        
    }
    
    
    // navigates to AboutUsViewController
    @IBAction func aboutUsPressed(_ sender: UIButton) {
        
        let aboutUsViewController = AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
        self.navigationController?.pushViewController(aboutUsViewController, animated: true)
        
    }
    
    
    @IBAction func fbPressed(_ sender: UIButton) {
        
        let url = URL.init(string: "https://www.facebook.com/engineeringforchange")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    

    @IBAction func twitterPressed(_ sender: UIButton) {
        
        let url = URL.init(string:"https://twitter.com/engineer4change")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)

        
    }
    
    
    @IBAction func youtubePressed(_ sender: UIButton) {
        
        let url = URL.init(string: "https://www.youtube.com/user/engineeringforchange")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    // allows cell selection by pressing on the cell's textView
    func selectAction(sender : UITapGestureRecognizer) {
        
        
        self.tableView(self.sectorTableView, didSelectRowAt: IndexPath(row: sender.view!.tag, section: 0))
        
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
