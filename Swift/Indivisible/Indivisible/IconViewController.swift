//
//  IconViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 8/1/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit


class IconViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let iconURL = "http://52.39.71.64:8080/Indivisible_API/profile/my/photo"
    
    @IBOutlet var iconImageView: UIImageView!
    
    let imagePicker =  UIImagePickerController()
    
    @IBAction func iconPerformActions(sender: AnyObject) {
        let iconAlertController = UIAlertController(title: nil, message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let takePictureAction = UIAlertAction(title: "Take a picture", style:  UIAlertActionStyle.Default){action in
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        iconAlertController.addAction(takePictureAction)
        let pickupPictureAction = UIAlertAction(title: "Pick up a picture from you phone", style:  UIAlertActionStyle.Default){action in
            self.imagePicker.sourceType = .SavedPhotosAlbum
            self.imagePicker.allowsEditing = true
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        iconAlertController.addAction(pickupPictureAction)
        let savePictureAction = UIAlertAction(title: "Save picture as your icon", style:  UIAlertActionStyle.Default){action in
            let iconUrl: NSURL = NSURL(string: self.iconURL)!
            let requestIcon = NSMutableURLRequest(URL: iconUrl)
            let sessionIcon = NSURLSession.sharedSession()
            requestIcon.HTTPMethod = "PATCH"
            let userDefault = NSUserDefaults.standardUserDefaults()
            let user_token = userDefault.stringForKey("access_token")!
            requestIcon.setValue("Bearer \(user_token)", forHTTPHeaderField: "Authorization")
            requestIcon.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let image = self.iconImageView.image {

                if let imageStr = UIImagePNGRepresentation(image) {
                    let base64Img = imageStr.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
                    let sendData = ["format":"image/png", "base64Data":base64Img] as NSDictionary
                    do {
                        if let jsonBody=try NSJSONSerialization.dataWithJSONObject(sendData, options: .PrettyPrinted) as NSData? {
                            requestIcon.HTTPBody = jsonBody
                            let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
                            let taskData = sessionIcon.dataTaskWithRequest(requestIcon){data, response, error in
                                if let httpError = error {
                                    print("\(httpError)")
                                } else {
                                    do{
                                        if let jsonResult=try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                                            print("jsonResult:\(jsonResult)")
                                        }
                                        
                                    } catch let error as NSError {
                                        print("An error occurred: \(error)")
                                    }
                                }
                                dispatch_semaphore_signal(semaphore)
                            }
                            taskData.resume()
                            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
                        }
                    } catch let error as NSError {
                        print("An error occurred: \(error)")
                    }
                    

                }
            }
        }
        iconAlertController.addAction(savePictureAction)
        iconAlertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(iconAlertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        iconImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let user_token = userDefault.stringForKey("access_token")!
        let iconUrl: NSURL = NSURL(string: "\(iconURL)?access_token=\(user_token)")!
        let requestIcon = NSMutableURLRequest(URL: iconUrl)
        let sessionIcon = NSURLSession.sharedSession()
        requestIcon.HTTPMethod = "GET"
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)

        let taskIcon = sessionIcon.dataTaskWithRequest(requestIcon){data, response, error in
            if let httpError = error {
                print("\(httpError)")
            } else {
                if let rawData = data {
                    self.iconImageView.opaque = false
                    self.iconImageView.image = UIImage(data: rawData)!
                }
            }
            dispatch_semaphore_signal(semaphore)
        }
        taskIcon.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
