//
//  SignupViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/30/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    
    @IBAction func backToLogin(sender: AnyObject) {
        self.performSegueWithIdentifier("showLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(sender: AnyObject) {
        if let emailText = email.text {
            let url: NSURL = NSURL(string: "http://52.39.71.64:8080/Indivisible_API/account/signup/initiate")!
            let request = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            let postData = ["email": emailText]
            
            var serverCallFailed = false
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postData, options: NSJSONWritingOptions(rawValue: 0))
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = session.dataTaskWithRequest(request){data, response, error in
                    do{
                        if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                            print("AsSynchronous\(jsonResult)")
                            if let json_error = jsonResult.objectForKey("errorCode") {
                                if let errorMessage = jsonResult.objectForKey("message") {
                                    let alertView = UIAlertController(title: "Signed Up Failed",
                                                                      message: errorMessage as? String, preferredStyle:.Alert)
                                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                                    alertView.addAction(okAction)
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.presentViewController(alertView, animated: true, completion: nil)
                                    }
                                    return
                                }
                            } else {
                                if let signupMessage = jsonResult.objectForKey("message") {
                                    let alertView = UIAlertController(title: "Signed Up Successfully",
                                                                      message: signupMessage as? String, preferredStyle:.ActionSheet)
                                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                                    alertView.addAction(okAction)
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.presentViewController(alertView, animated: true, completion: nil)
                                    }
                                }
                                
                            }
                            serverCallFailed = false
                        }
                    } catch let error as NSError {
                        print("An error occurred: \(error)")
                    }
                }
                
                task.resume()

            } catch let error as NSError {
                serverCallFailed = true
                print("An error occurred: \(error)")
            }
            
            if serverCallFailed {
                let alertView = UIAlertController(title: "Server Error",
                                                  message: "We're experiencing server issue right now, please try again later." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Failed Again!", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
}
