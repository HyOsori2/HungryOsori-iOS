//
//  SubscriptionListViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class SubscriptionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var crawlerTableView: UITableView!
    
    var subscriptions = []
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var final_array = [Osori]()
    var unscribe_id:String?

    var subcount : Int?
    

    var temp_crawler_list = [Osori]()
    
    
        
    var crawlers:Crawlers? = Crawlers()

    override func viewDidLoad() {
        for i in 0...4
        {
            let temp_id = ShareData.sharedInstance.entireList[i].id
            let temp_title = ShareData.sharedInstance.entireList[i].title
            let temp_des = ShareData.sharedInstance.entireList[i].description
            let temp_image = ShareData.sharedInstance.entireList[i].image
            
            temp_crawler_list.append(Osori(id: temp_id, title: temp_title, description: temp_des, image: temp_image))
        }
        subscriptions = []
        
        if((userID != nil) && (userKey != nil))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscriptions = []
        
        if((userID != nil) && (userKey != nil))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
    }
    
    func makePostRequestSubscribeList(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_subscription_list")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            do {
                let JsonData =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = JsonData {
                    self.subscriptions = (parseJSON["subscriptions"])! as! NSArray
                }
                self.subcount = self.subscriptions.count
                print(self.subscriptions)
                self.final_array = []
                for i in 0...4
                {
                    if (self.subcount == 0)
                    {
                        break
                    }
                    else
                    {
                        for j in 0...(self.subcount!-1)
                        {
                            if ((self.temp_crawler_list[i].id) == self.subscriptions[j] as! String)
                            {
                                let iid:String?  = self.temp_crawler_list[i].id
                                let ttile:String? = self.temp_crawler_list[i].title
                                let ddes:String? = self.temp_crawler_list[i].description
                                let iimage:String? = self.temp_crawler_list[i].image
                                self.final_array.append(Osori(id: iid! , title: ttile!, description: ddes!
                                , image: iimage!))// append가 아니라 insert를해야하는지.
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
            self.crawlerTableView.reloadData()
        }
        task.resume()
    }
    
    
    func makePostRequestUnsubscrcibe(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_unsubscribe_crawler")!)
        let subid = unscribe_id
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)&crawler_id=\(subid!)"
        print("Unnnnnnsubscribe_postString! : \(postString)!")
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString2 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("UnSubscribe_responseString!! \(responseString2)")
        }
        task2.resume()
        self.crawlerTableView.reloadData()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (subcount == nil)
        {
            return 0
        }
        else
        {
            return self.subcount!
        }
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let subcell = crawlerTableView.dequeueReusableCellWithIdentifier("subcell", forIndexPath: indexPath) as! SubscribeTableViewCell
        let cc = self.final_array[indexPath.row]
        
        subcell.subtitle.text = cc.title
        subcell.subdes.text = cc.description
        let unwrapped:String = cc.image
        let url = NSURL(string: unwrapped)!
        
        if let data = NSData(contentsOfURL : url)
        {
            if let realimage = UIImage(data: data)
            {
                subcell.subimage.image = realimage
                if(subcell.subimage.image == nil)
                {
                    print("threre is no image!!")
                }
            }
        }
        subcell.unsubscribeButton.tag = indexPath.row
        
        return subcell
    }
    
    @IBAction func unsubscribeButton(sender: AnyObject) {
        unscribe_id = self.final_array[sender.tag].id
        ShareData.sharedInstance.unsubscriptionList.append(Osori(id: self.final_array[sender.tag].id, title: self.final_array[sender.tag].title, description: self.final_array[sender.tag].description, image: self.final_array[sender.tag].image))
        print(ShareData.sharedInstance.unsubscriptionList.count)
        print("remove index : \(unscribe_id)")
        self.final_array.removeAtIndex(sender.tag)
        makePostRequestUnsubscrcibe()
        self.subcount! -= 1
        self.crawlerTableView.reloadData()
        
        
    }
   
}