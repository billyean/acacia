//
//  JoinDecisionViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 8/1/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class JoinDecisionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var answerTextView : UITextView?
    
    var decision : NSDictionary?
    
    var resignedViews = Set<UIView>()
    
    func setDecisionInfo(decisionInfo : NSDictionary?) {
        self.decision = decisionInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        for view in resignedViews {
            view.resignFirstResponder()
        }
    }
    
    
    func submitAnswer() {
        let joiningURL: NSURL = NSURL(string: "http://52.39.71.64:8080/Indivisible_API/decisions/2/join")!
        let request = NSMutableURLRequest(URL: joiningURL)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let userDefault = NSUserDefaults.standardUserDefaults()
        let user_token = userDefault.stringForKey("access_token")!
        let token = "Bearer \(user_token)"

        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let sendData = ["answer":answerTextView!.text] as NSDictionary
            do {
                if let jsonBody=try NSJSONSerialization.dataWithJSONObject(sendData, options: .PrettyPrinted) as NSData? {
                    request.HTTPBody = jsonBody
                    var submitted = false
                    var message = ""
                    let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)

                    let task = session.dataTaskWithRequest(request){data, response, error in
                        if let httpError = error {
                            print("\(httpError)")
                        } else {
                            do{
                                if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                                    print("jsonResult:\(jsonResult)")
                                    if let json_error = jsonResult.objectForKey("errorCode") {
                                        let errorMsg = jsonResult.objectForKey("message")
                                        let alertView = UIAlertController(title: "Error happened when submitting answer", message: errorMsg! as? String, preferredStyle:.Alert)
                                        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                                        alertView.addAction(okAction)
                                        dispatch_async(dispatch_get_main_queue()) {
                                            self.presentViewController(alertView, animated: true, completion: nil)
                                        }
                                    } else {
                                        submitted = true
                                        message = (jsonResult.objectForKey("message") as? String)!
                                    }
                                }

                            } catch let error as NSError {
                                print("An error occurred: \(error)")
                            }
                        }
                        dispatch_semaphore_signal(semaphore)
                    }
                    task.resume()
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
                    if submitted {
                        let alertView = UIAlertController(title: "Submitted", message: message, preferredStyle:.Alert)
                        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alertView.addAction(okAction)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(alertView, animated: true, completion: nil)
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }
                }
            } catch let error as NSError {
                let alertView = UIAlertController(title: "Error happened when serialize answer to JSON", message:  error.description, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertView.addAction(okAction)
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return 44
        case (0, 1):
            return 172
        case (1, 0):
            return 286
        case (1, 1):
            return 40
        default:
            return 56
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellId:String
        
        cellId = "JoinDecisionCell"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                let titleLabel = UILabel(frame: CGRect(x: 8, y: 6, width: 400, height: 32))
                titleLabel.numberOfLines = 2
                titleLabel.text = decision!["title"] as? String
                titleLabel.font = UIFont(name: "Menlo", size: 14)
                cell.contentView.addSubview(titleLabel)
            case (0, 1):
                let descLabel = UILabel(frame: CGRect(x: 8, y: 6, width: 400, height: 160))
                descLabel.numberOfLines = 8
                descLabel.text = decision!["description"] as? String
                descLabel.font = UIFont(name: "Menlo", size: 14)
                cell.contentView.addSubview(descLabel)
            case (1, 0):
                let answerView = UIView(frame: CGRect(x: 0, y: 0, width: 416, height: 286))
                
                let answerLabelFrame = CGRect(x: 16, y: 6, width: 384 , height: 28)
                let answerLabel = UILabel(frame: answerLabelFrame)
                answerLabel.font = UIFont(name: "Menlo", size: 14)
                answerLabel.text = "Please input your solution here:"
                answerView.addSubview(answerLabel)
                
                answerTextView = UITextView(frame: CGRect(x: 0, y: 40, width: 416, height: 240))
                answerTextView?.backgroundColor = UIColor.lightGrayColor()
                answerTextView?.textColor = UIColor.whiteColor()
                answerTextView?.font = UIFont(name: "Menlo", size: 14)
                resignedViews.insert(answerTextView!)
                answerView.addSubview(answerTextView!)
                
                cell.contentView.addSubview(answerView)
            case (1, 1):
                let submitBtn = UIButton(frame: CGRect(x: 48, y: 6, width: 320, height: 28))
                submitBtn.backgroundColor = UIColor(red: 102, green: 153, blue: 255, alpha: 1)
                submitBtn.opaque = false
                submitBtn.setTitle("Submit", forState: .Normal)
                submitBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                submitBtn.addTarget(self, action: #selector(JoinDecisionViewController.submitAnswer), forControlEvents: .TouchDown)
                cell.contentView.addSubview(submitBtn)
            default:
                break
            }
            return cell
        }
    }

}
