//
//  DecisionViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/12/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class DecisionViewController: UITableViewController {
    var selection = 0
    
    let public_selections = ["Public", "Private","Joined", "Created" , "Published", "Finished"]
    
    let admin_selections = ["Published", "In Process", "Finished", "Completed", "Saved"]
    
    var personel_view = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userDefault = NSUserDefaults.standardUserDefaults()
        let authories = userDefault.arrayForKey("authorities") as? [String]
        personel_view = authories! == ["ROLE_PUBLIC_USER"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personel_view ? public_selections.count : admin_selections.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellId:String
        var label: String
        
        cellId = "DecisionCell"
        label = personel_view ? public_selections[indexPath.row] : admin_selections[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell.textLabel?.text = label
            cell.textLabel?.font = UIFont(name: "Calibre", size: 16)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selection = indexPath.row
        performSegueWithIdentifier("PublishedSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let targetVC  = segue.destinationViewController as? DecisionDetailTableViewController
        targetVC?.setTab(personel_view ? public_selections[selection] : admin_selections[selection])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
