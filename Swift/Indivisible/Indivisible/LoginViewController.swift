//
//  LoginViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/12/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var rememberUsername: UISwitch!
    
    @IBAction func signIn(sender: AnyObject) {
        if let userNameTxt = userName.text, let passwordTxt = password.text {
            if (userNameTxt != "" && passwordTxt != "" ) {
                login(userName.text!, pass:password.text!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.resignFirstResponder()
        password.resignFirstResponder()

        let userDefaults = NSUserDefaults.standardUserDefaults()
        let rememberMe = userDefaults.boolForKey("rememberMe")
        if rememberMe {
            rememberUsername.setOn(true, animated: true)
            userName.text = userDefaults.objectForKey("username") as? String
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(user: String, pass: String) {
        if rememberUsername.on {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(user, forKey: "username")
            userDefaults.setValue(true, forKey: "rememberMe")
        }
        
        let url: NSURL = NSURL(string: "http://www.indivigroup.com:8080/Indivisible_API/oauth/token")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let uri = "grant_type=password&client_id=indivisible_app&client_secret=indivisible_app_s3cr3t&username=\(user)&password=\(pass)"
        let uriData = uri.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())! + "&scope=read%2Cwrite%2Ctrust"
        request.HTTPBody = uriData.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request){data, response, error in
            var serverCallFailed = true
            do{
                if let servererror = error {
                    serverCallFailed = true
                } else {
                    if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        //print("AsSynchronous\(jsonResult)")
                        if let json_error = jsonResult.objectForKey("error") {
                            let alertView = UIAlertController(title: "Login Failed",
                                                              message: "The Username or Password you entered is incorrect. Please click 'Try Again' to reenter you Username and Password" as String, preferredStyle:.Alert)
                            let okAction = UIAlertAction(title: "Try Again!", style: .Default, handler: nil)
                            alertView.addAction(okAction)
                            dispatch_async(dispatch_get_main_queue()) {
                                self.presentViewController(alertView, animated: true, completion: nil)
                            }
                        } else {
                            if let token = jsonResult.objectForKey("access_token") {
                                let userDefault = NSUserDefaults.standardUserDefaults()
                                userDefault.setObject(token, forKey: "access_token")
                                if let authorities = jsonResult.objectForKey("authorities") {
                                    userDefault.setObject(authorities, forKey: "authorities")
                                }
                                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                                    self.performSegueWithIdentifier("loginSucceed", sender: self)
                                }
                            }
                        }
                        serverCallFailed = false
                    }
                }
            } catch let error as NSError {
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
        task.resume()

    }

}
