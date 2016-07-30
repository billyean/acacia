//
//  DecisionViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/12/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class DecisionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellId:String
        var label: String
        
        switch(indexPath.row) {
        case 0:
            cellId = "PublishedCell"
            label = "Published"
        case 1:
            cellId = "InProgressCell"
            label = "In Process"
        case 2:
            cellId = "FinishedCell"
            label = "Finished"
        case 3:
            cellId = "CompletedCell"
            label = "Completed"
        default:
            cellId = "SavedCell"
            label = "Saved"
        }
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell.textLabel?.text = label
            cell.textLabel?.font = UIFont.systemFontOfSize(24)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.textLabel?.text = " I was changed"
        switch(indexPath.row) {
        case 0:
            performSegueWithIdentifier("PublishedSegue", sender: nil)
        default:
            performSegueWithIdentifier("PublishedSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let targetVC = segue.destinationViewController
        print("%s", segue.identifier)
        print("%s", targetVC.title)
        
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
