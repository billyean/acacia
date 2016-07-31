//
//  PublishedTableViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/29/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class DecisionDetailTableViewController: UITableViewController {
    
    var tabName:String = ""
    
    var publishedDecisions: [NSDictionary] = []
    
    @IBOutlet var navigationTopBar: UINavigationItem!
    
    var personel_view = false
    
    func setTab(tabName: String) {
        self.tabName = tabName
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let joinedAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Join"){ action, indexPath in
            
        }
        return [joinedAction]
    }
    
    func decisionsUri(tabName: String) -> String {
        if personel_view {
            switch (tabName) {
            case "Public":
                return "decisions/secured?page=0&accessLevel=PUBLIC"
            case "Private":
                return "decisions/secured?page=0&accessLevel=TARGET_AUDIENCE"
            case "Joined":
                return "decisions/my/joined?page=0"
            case "Created":
                return "decisions/user?status=READY_TO_PUBLISH"
            case "Published":
                return "decisions/user?status=PUBLISHED"
            default:
                return "decisions/user?status=FINISHED"
            }
        } else {
            switch (tabName) {
            case "Published":
                return "decisions/corp?status=PUBLISHED"
            case "In Process":
                return "decisions/corp?status=IN_PROCESS"
            case "Finished":
                return "decisions/corp?status=FINISHED"
            case "Completed":
                return "decisions/corp?status=COMPLETED"
            default:
                return "decisions/corp?status=READY_TO_PUBLISH"
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let authories = userDefault.arrayForKey("authorities") as? [String]
        personel_view = authories! == ["ROLE_PUBLIC_USER"]
        navigationTopBar?.title = "\(tabName) Decisions"
        
        let uri = decisionsUri(tabName)
        
        let url: NSURL = NSURL(string: "http://www.indivigroup.com:8080/Indivisible_API/\(uri)")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        let user_token = userDefault.stringForKey("access_token")!
        let token = "Bearer \(user_token)"
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        let task = session.dataTaskWithRequest(request){data, response, error in
            if let httpError = error {
                print("\(httpError)")
            } else {
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
        tableView.rowHeight = 120
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
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId)
            cell.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            
            let decision = publishedDecisions[indexPath.row]
            let state = String(decision["state"]!)
            cell.textLabel?.text = "State: \(state)"
            cell.textLabel?.font = UIFont(name: "Calibri", size: 20)
            
            cell.detailTextLabel?.numberOfLines = 3
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.detailTextLabel?.text = String(decision["title"]!)
            cell.detailTextLabel?.font = UIFont(name: "Calibri", size: 16)
            
            let imgStr = String(decision["tileViewImage"]!)
            let base64Img = imgStr[imgStr.startIndex.advancedBy(22)..<imgStr.endIndex]
            
            let dataDecoded = NSData(base64EncodedString: base64Img, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            let size = CGSize(width: 80, height: 80)
            cell.imageView?.image = imageWithImage(UIImage(data: dataDecoded)!, scaledToSize: size)
            return cell
        }
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
