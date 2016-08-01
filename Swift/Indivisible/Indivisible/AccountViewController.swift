//
//  AccountViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/12/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    var personalData : NSDictionary = [:]
    
    let personalURL = "http://www.indivigroup.com:8080/Indivisible_API/profile/my"
    
    let companyOwnURL = "http://www.indivigroup.com:8080/Indivisible_API/profile/my/company"
    
    let iconURL = "http://52.39.71.64:8080/Indivisible_API/profile/my/photo"
    
    var iconUIView : UIImageView? = nil
    
    var useTouchID = false
    
    var resignedViews = Set<UIView>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        useTouchID = userDefault.boolForKey("useTouchID")
        let authories = userDefault.arrayForKey("authorities") as? [String]
        let personel_view = authories! == ["ROLE_PUBLIC_USER"]
        let dataURL = personel_view ? personalURL : companyOwnURL
        
        let dataUrl: NSURL = NSURL(string: dataURL)!
        let requestData = NSMutableURLRequest(URL: dataUrl)
        let sessionData = NSURLSession.sharedSession()
        requestData.HTTPMethod = "GET"
        let user_token = userDefault.stringForKey("access_token")!
        
        requestData.setValue("Bearer \(user_token)", forHTTPHeaderField: "Authorization")
        requestData.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField: "Accept")
        
        let httpCallGroup = dispatch_group_create()
        dispatch_group_enter(httpCallGroup)
        let taskData = sessionData.dataTaskWithRequest(requestData){data, response, error in
            if let httpError = error {
                print("\(httpError)")
            } else {
                do{
                    if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        print("AsSynchronous\(jsonResult)")
                        self.personalData = jsonResult
                    }
                    
                } catch let error as NSError {
                    print("An error occurred: \(error)")
             
                }
            }
            dispatch_group_leave(httpCallGroup)
        }
        taskData.resume()
        
        let iconUrl: NSURL = NSURL(string: "\(iconURL)?access_token=\(user_token)")!
        let requestIcon = NSMutableURLRequest(URL: iconUrl)
        let sessionIcon = NSURLSession.sharedSession()
        requestIcon.HTTPMethod = "GET"
        dispatch_group_enter(httpCallGroup)
        let taskIcon = sessionIcon.dataTaskWithRequest(requestIcon){data, response, error in
            if let httpError = error {
                print("\(httpError)")
            } else {
                let size = CGSize(width: 60, height: 60)
                
                if let rawData = data {
                    self.iconUIView = UIImageView(image: self.imageWithImage(UIImage(data: rawData)!, scaledToSize: size))
                }
            }
            dispatch_group_leave(httpCallGroup)
        }
        taskIcon.resume()
        dispatch_group_wait(httpCallGroup, DISPATCH_TIME_FOREVER)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        for view in resignedViews {
            view.resignFirstResponder()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return 72
        case (1, 1):
            return 114
        default:
            return 56
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 5
        default:
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "DecisionCell_\(indexPath.section)_\(indexPath.row)"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 72))
                
                let iconLabelLabel = CGRect(x: 24, y: 16, width: 96, height: 30)
                let iconLabel = UILabel(frame: iconLabelLabel)
                iconLabel.text = "Icon:"
                iconLabel.font = UIFont(name: "Calibre", size: 24)
                iconView.addSubview(iconLabel)
                
                let frameIconImageView = CGRect(x: 284, y: 6, width: 60, height: 72)
                let iconImageView = UITextView(frame: frameIconImageView)
                iconImageView.addSubview(iconUIView!)
                resignedViews.insert(iconImageView)
                iconView.addSubview(iconImageView)
                
                cell.contentView.addSubview(iconView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (0, 1):
                let nameView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let nameLabelLabel = CGRect(x: 24, y: 8, width: 96, height: 30)
                let nameLabel = UILabel(frame: nameLabelLabel)
                nameLabel.text = "Name"
                nameLabel.font = UIFont(name: "Calibre", size: 24)
                nameView.addSubview(nameLabel)
                
                let nameValueLabelSize = CGRect(x: 140, y: 8, width: 204, height: 30)
                let nameValueLabel = UILabel(frame: nameValueLabelSize)
                nameValueLabel.text = personalData.valueForKey("fullName") as? String
                nameValueLabel.font = UIFont(name: "Calibre", size: 24)
                nameValueLabel.textAlignment = NSTextAlignment.Right
                nameView.addSubview(nameValueLabel)
                
                cell.contentView.addSubview(nameView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (0, 2):
                let usernameView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let usernameLabelLabel = CGRect(x: 24, y: 8, width: 96, height: 30)
                let usernameLabel = UILabel(frame: usernameLabelLabel)
                usernameLabel.text = "User Name"
                usernameLabel.font = UIFont(name: "Calibre", size: 24)
                usernameView.addSubview(usernameLabel)
                
                let usernameValueLabelSize = CGRect(x: 140, y: 8, width: 204, height: 30)
                let usernameValueLabel = UILabel(frame: usernameValueLabelSize)
                usernameValueLabel.text = personalData.valueForKey("username") as? String
                usernameValueLabel.font = UIFont(name: "Calibre", size: 24)
                usernameValueLabel.textAlignment = NSTextAlignment.Right
                usernameView.addSubview(usernameValueLabel)
                
                cell.contentView.addSubview(usernameView)
            case (0, 3):
                let passwordView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let passwordLabelLabel = CGRect(x: 24, y: 8, width: 96, height: 30)
                let passwordLabel = UILabel(frame: passwordLabelLabel)
                passwordLabel.text = "Password"
                passwordLabel.font = UIFont(name: "Calibre", size: 24)
                passwordView.addSubview(passwordLabel)
                
                let passwordValueLabelSize = CGRect(x: 140, y: 8, width: 204, height: 30)
                let passwordValueLabel = UILabel(frame: passwordValueLabelSize)
                passwordValueLabel.text = "**********"
                passwordValueLabel.font = UIFont(name: "Calibre", size: 24)
                passwordValueLabel.textAlignment = NSTextAlignment.Right
                passwordView.addSubview(passwordValueLabel)
                
                cell.contentView.addSubview(passwordView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (0, 4):
                let touchIDView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let touchIDLabelLabel = CGRect(x: 24, y: 8, width: 120, height: 30)
                let touchIDLabel = UILabel(frame: touchIDLabelLabel)
                touchIDLabel.text = "Use Touch ID"
                touchIDLabel.font = UIFont(name: "Calibre", size: 24)
                touchIDView.addSubview(touchIDLabel)
                
                let touchIDSwitchSize = CGRect(x: 300, y: 8, width: 44, height: 30)
                let touchIDSwitch = UISwitch(frame: touchIDSwitchSize)
                touchIDSwitch.setOn(false, animated: true)
                touchIDView.addSubview(touchIDSwitch)
                
                cell.contentView.addSubview(touchIDView)
            case (1, 0):
                let telView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let telLabelFrame = CGRect(x: 24, y: 8, width: 96, height: 30)
                let telLabel = UILabel(frame: telLabelFrame)
                telLabel.text = "Telphone"
                telLabel.font = UIFont(name: "Calibre", size: 24)
                telView.addSubview(telLabel)
                
                let telValueLabelFrame = CGRect(x: 140, y: 8, width: 204, height: 30)
                let telValueLabel = UILabel(frame: telValueLabelFrame)
                telValueLabel.text = personalData.valueForKey("phone") as? String
                telValueLabel.font = UIFont(name: "Calibre", size: 24)
                telValueLabel.textAlignment = NSTextAlignment.Right
                telView.addSubview(telValueLabel)
                
                cell.contentView.addSubview(telView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (1, 1):
                let addressView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let addressLabelFrame = CGRect(x: 24, y: 8, width: 96, height: 30)
                let addressLabel = UILabel(frame: addressLabelFrame)
                addressLabel.text = "Address"
                addressLabel.font = UIFont(name: "Calibre", size: 24)
                addressView.addSubview(addressLabel)
                
                let addressDetailViewFrame = CGRect(x: 140, y: 0, width: 204, height: 114)
                let addressDetailView = UIView(frame: addressDetailViewFrame)
                let addressValueLabelFrame = CGRect(x: 0, y: 6, width: 204, height: 30)
                let addressValueLabel = UILabel(frame: addressValueLabelFrame)
                addressValueLabel.text = personalData.valueForKey("address") as? String
                addressValueLabel.font = UIFont(name: "Calibre", size: 24)
                addressValueLabel.textAlignment = NSTextAlignment.Right
                addressDetailView.addSubview(addressValueLabel)
                let cityStateZipValueLabelFrame = CGRect(x: 0, y: 42, width: 204, height: 30)
                let cityStateZipValueLabel = UILabel(frame: cityStateZipValueLabelFrame)
                let city = personalData.valueForKey("city") as? String
                let state = personalData.valueForKey("state") as? String
                let zipCode = personalData.valueForKey("zipCode") as? String
                cityStateZipValueLabel.text = "\(city!), \(state!), \(zipCode!)"
                cityStateZipValueLabel.font = UIFont(name: "Calibre", size: 24)
                cityStateZipValueLabel.textAlignment = NSTextAlignment.Right
                addressDetailView.addSubview(cityStateZipValueLabel)
                let countryValueLabelFrame = CGRect(x: 0, y: 78, width: 204, height: 30)
                let countryValueLabel = UILabel(frame: countryValueLabelFrame)
                countryValueLabel.text = personalData.valueForKey("country") as? String
                countryValueLabel.font = UIFont(name: "Calibre", size: 24)
                countryValueLabel.textAlignment = NSTextAlignment.Right
                addressDetailView.addSubview(countryValueLabel)
                
                addressView.addSubview(addressDetailView)
                
                cell.contentView.addSubview(addressView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (1, 2):
                let timezoneView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let timezoneLabelFrame = CGRect(x: 24, y: 8, width: 96, height: 30)
                let timezoneLabel = UILabel(frame: timezoneLabelFrame)
                timezoneLabel.text = "Telphone"
                timezoneLabel.font = UIFont(name: "Calibre", size: 24)
                timezoneView.addSubview(timezoneLabel)
                
                let timezoneValueLabelFrame = CGRect(x: 140, y: 8, width: 204, height: 30)
                let timezoneValueLabel = UILabel(frame: timezoneValueLabelFrame)
                timezoneValueLabel.text = personalData.valueForKey("phone") as? String
                timezoneValueLabel.font = UIFont(name: "Calibre", size: 24)
                timezoneValueLabel.textAlignment = NSTextAlignment.Right
                timezoneView.addSubview(timezoneValueLabel)
                
                cell.contentView.addSubview(timezoneView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (1, 3):
                let birthdayView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let birthdayLabelFrame = CGRect(x: 24, y: 8, width: 96, height: 30)
                let birthdayLabel = UILabel(frame: birthdayLabelFrame)
                birthdayLabel.text = "Birthday"
                birthdayLabel.font = UIFont(name: "Calibre", size: 24)
                birthdayView.addSubview(birthdayLabel)
                
                let birthdayValueLabelFrame = CGRect(x: 140, y: 8, width: 204, height: 30)
                let birthdayValueLabel = UILabel(frame: birthdayValueLabelFrame)
                birthdayValueLabel.text = personalData.valueForKey("birthday") as? String
                birthdayValueLabel.font = UIFont(name: "Calibre", size: 24)
                birthdayValueLabel.textAlignment = NSTextAlignment.Right
                birthdayView.addSubview(birthdayValueLabel)
                
                cell.contentView.addSubview(birthdayView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (1, 4):
                let languageView = UIView(frame: CGRect(x: 0, y: 0, width: 368, height: 56))
                
                let languageLabelFrame = CGRect(x: 24, y: 8, width: 96, height: 30)
                let languageLabel = UILabel(frame: languageLabelFrame)
                languageLabel.text = "Telphone"
                languageLabel.font = UIFont(name: "Calibre", size: 24)
                languageView.addSubview(languageLabel)
                
                let languageValueLabelFrame = CGRect(x: 140, y: 8, width: 204, height: 30)
                let languageValueLabel = UILabel(frame: languageValueLabelFrame)
                
                var language = ""
                if let lan = personalData.valueForKey("preferredLanguage") as? String {
                    switch lan {
                    case "en":
                    language = "English"
                    case "fr":
                    language = "French"
                    default:
                    language = "Chinese"
                    }
                }
                languageValueLabel.text = language
                languageValueLabel.font = UIFont(name: "Calibre", size: 24)
                languageValueLabel.textAlignment = NSTextAlignment.Right
                languageView.addSubview(languageValueLabel)
                
                cell.contentView.addSubview(languageView)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case (3, 0):
                let buttonView = UIView(frame: CGRect(x: 68, y: 6, width: 232, height: 44))
                let signoutButton = UIButton(type: UIButtonType.RoundedRect)
                signoutButton.setTitle("Sign Out", forState: UIControlState.Normal)
                signoutButton.titleLabel?.font = UIFont(name: "Calibre", size: 24)
                signoutButton.addTarget(self, action: #selector(self.signOut), forControlEvents: UIControlEvents.TouchDown)
                buttonView.addSubview(signoutButton)
                cell.contentView.addSubview(buttonView)
            default:
                break;
            }
            return cell
        }
    }
    
    func signOut(sender: UIButton) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}
