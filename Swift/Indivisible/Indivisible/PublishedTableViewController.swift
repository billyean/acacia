//
//  PublishedTableViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/29/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class PublishedTableViewController: UITableViewController {
    
    var publishedDecisions: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url: NSURL = NSURL(string: "http://www.indivigroup.com:8080/Indivisible_API/decisions/corp?status=PUBLISHED")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        let userDefault = NSUserDefaults.standardUserDefaults()
        let user_token = userDefault.stringForKey("access_token")!
        let token = "Bearer \(user_token)"
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        let task = session.dataTaskWithRequest(request){data, response, error in
            if let httpError = error {
                print("\(httpError)")
            } else {

                //print("data=\(data)")
                do{
                if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [NSDictionary] {
                    print("AsSynchronous\(jsonResult)")
                    self.publishedDecisions = jsonResult
                }
                
            } catch let error as NSError {
                print("An error occurred: \(error)")
            }
            }
            dispatch_semaphore_signal(semaphore)
        }
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishedDecisions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "DecisionId"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            let decision = publishedDecisions[indexPath.row]
            cell.textLabel?.text = String(decision["title"]!)
            cell.imageView?.image = UIImage(data: (decision["tileViewImage"]?.dataUsingEncoding(NSASCIIStringEncoding)!)!)
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            let decision = publishedDecisions[indexPath.row]
            cell.textLabel?.text = String(decision["title"]!)
            
            let imgStr = String(decision["tileViewImage"]!)
            let base64Img = imgStr[imgStr.startIndex.advancedBy(22)..<imgStr.endIndex]
            
            let dataDecoded = NSData(base64EncodedString: base64Img, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            cell.imageView?.image = UIImage(data: dataDecoded)
            cell.textLabel?.font = UIFont.systemFontOfSize(14)
            return cell
        }
        
    }
}
