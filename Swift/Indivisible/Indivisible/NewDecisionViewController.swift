//
//  NewDecisionViewController.swift
//  Indivisible
//
//  Created by Yan, Tristan on 7/12/16.
//  Copyright © 2016 Tristan, Yan. All rights reserved.
//

import UIKit

class NewDecisionViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let categories = ["Art", "Business", "Education", "Entertainment", "Games", "Lifestyle", "Nonprofit", "Politics", "Science&Tech", "Sports"]
    
    var resignedViews = Set<UIView>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func publishDecision() {
        
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        for view in resignedViews {
            view.resignFirstResponder()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.accessibilityIdentifier! {
        case "Category":
            return categories.count
        default:
            return NSTimeZone.knownTimeZoneNames().count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.accessibilityIdentifier! {
        case "Category":
            return categories[row]
        default:
            return NSTimeZone.knownTimeZoneNames()[row]
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 6
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return 124
        case (0, 1):
            return 64
        case (0, 5):
            return 266
        case (1, 0):
            return 174
        case (1, 1):
            return 174
        case (1, 2):
            return 94
        default:
            return 56
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Basic"
        case 1:
            return "Configuration"
        case 2:
            return "Reward"
        default:
            return "Unknown"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "DecisionCell_\(indexPath.section)_\(indexPath.row)"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell.backgroundColor = UIColor.lightGrayColor()
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                let titleView = UIView(frame: CGRect(x: 16, y: 0, width: 384, height: 124))
                
                let frameTitleLabel = CGRect(x: 0, y: 6, width: 384, height: 28)
                let titleLabel = UILabel(frame: frameTitleLabel)
                titleLabel.text = "Decision Title:"
                titleView.addSubview(titleLabel)
                
                let frameTitleTextView = CGRect(x: 0, y: 40, width: 384, height: 78)
                let titleTextView = UITextView(frame: frameTitleTextView)
                titleTextView.layer.borderWidth = CGFloat(1.0)
                titleTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
                resignedViews.insert(titleTextView)
                titleView.addSubview(titleTextView)
                
                cell.contentView.addSubview(titleView)
            case (0, 1):
                let categoryView = UIView(frame: CGRect(x: 16, y: 8, width: 384, height: 48))
                
                let frameCategoryLabel = CGRect(x: 0, y: 6, width: 180 , height: 28)
                let categoryLabel = UILabel(frame: frameCategoryLabel)
                categoryLabel.text = "Please select category:"
                categoryView.addSubview(categoryLabel)
                
                let frameCategoriesPicker = CGRect(x: 202, y: 0, width: 180, height: 48)
                let categoriesPicker = UIPickerView(frame: frameCategoriesPicker)
                categoriesPicker.accessibilityIdentifier = "Category"
                categoriesPicker.layer.borderWidth = CGFloat(1.0)
                categoriesPicker.layer.borderColor = UIColor.blackColor().CGColor
                categoriesPicker.showsSelectionIndicator = true
                categoriesPicker.delegate = self
                categoriesPicker.dataSource = self
                categoryView.addSubview(categoriesPicker)
                
                cell.contentView.addSubview(categoryView)
            case (0, 2):
                let frameSubCategory = CGRect(x: 16, y: 8, width: 384, height: 40)
                let subCategory = UITextField(frame: frameSubCategory)
                subCategory.borderStyle = UITextBorderStyle.RoundedRect
                subCategory.placeholder = "Please input Sub Category here!"
                resignedViews.insert(subCategory)
                cell.contentView.addSubview(subCategory)
            case (0, 3):
                let frameDepatment = CGRect(x: 16, y: 8, width: 384, height: 40)
                let department = UITextField(frame: frameDepatment)
                department.borderStyle = UITextBorderStyle.RoundedRect
                department.placeholder = "Please input department"
                resignedViews.insert(department)
                cell.contentView.addSubview(department)
            case (0, 4):
                let frameAddTag = CGRect(x: 16, y: 8, width: 384, height: 40)
                let addTag = UITextField(frame: frameAddTag)
                addTag.borderStyle = UITextBorderStyle.RoundedRect
                addTag.placeholder = "Add Tags here!"
                resignedViews.insert(addTag)
                cell.contentView.addSubview(addTag)
            case (0, 5):
                let descView = UIView(frame: CGRect(x: 16, y: 0, width: 384, height: 266))
                
                let frameDescLabel = CGRect(x: 0, y: 6, width: 384, height: 28)
                let descLabel = UILabel(frame: frameDescLabel)
                descLabel.text = "Description:"
                descView.addSubview(descLabel)
                
                let frameDescTextView = CGRect(x: 0, y: 40, width: 384, height: 220)
                let descTextView = UITextView(frame: frameDescTextView)
                descTextView.layer.borderWidth = CGFloat(1.0)
                descTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
                resignedViews.insert(descTextView)
                descView.addSubview(descTextView)
                
                cell.contentView.addSubview(descView)
            case (1, 0):
                let startTimeView = UIView(frame: CGRect(x: 16, y: 0, width: 384, height: 174))
                
                let frameStartTimeLabel = CGRect(x: 0, y: 6, width: 384, height: 28)
                let startTimeLabel = UILabel(frame: frameStartTimeLabel)
                startTimeLabel.text = "Please Select Decsion Submission Start Time:"
                startTimeView.addSubview(startTimeLabel)
                
                let frameStartTimePicker = CGRect(x: 0, y: 40, width: 384, height: 128)
                let startTimePicker = UIDatePicker(frame: frameStartTimePicker)
                startTimePicker.layer.borderWidth = CGFloat(1.0)
                startTimePicker.layer.borderColor = UIColor.lightGrayColor().CGColor
                startTimeView.addSubview(startTimePicker)
                
                cell.contentView.addSubview(startTimeView)
            case (1, 1):
                let endTimeView = UIView(frame: CGRect(x: 16, y: 0, width: 384, height: 174))
                
                let frameEndTimeLabel = CGRect(x: 0, y: 6, width: 384, height: 28)
                let endTimeLabel = UILabel(frame: frameEndTimeLabel)
                endTimeLabel.text = "Please Select Decsion Submission Deadline:"
                endTimeView.addSubview(endTimeLabel)
                
                let frameEndTimePicker = CGRect(x: 0, y: 40, width: 384, height: 128)
                let endTimePicker = UIDatePicker(frame: frameEndTimePicker)
                endTimePicker.layer.borderWidth = CGFloat(1.0)
                endTimePicker.layer.borderColor = UIColor.lightGrayColor().CGColor
                endTimeView.addSubview(endTimePicker)
                
                cell.contentView.addSubview(endTimeView)
            case (1, 2):
                let timezoneView = UIView(frame: CGRect(x: 16, y: 0, width: 384, height: 94))
                
                let frameTimezoneLabel = CGRect(x: 0, y: 6, width: 384 , height: 28)
                let timezoneLabel = UILabel(frame: frameTimezoneLabel)
                timezoneLabel.text = "Please select timezone:"
                timezoneView.addSubview(timezoneLabel)
                
                let frameTimezonePicker = CGRect(x: 0, y: 40, width: 384, height: 48)
                let timezonePicker = UIPickerView(frame: frameTimezonePicker)
                timezonePicker.accessibilityIdentifier = "Timezone"
                timezonePicker.layer.borderWidth = CGFloat(1.0)
                timezonePicker.layer.borderColor = UIColor.blackColor().CGColor
                timezonePicker.showsSelectionIndicator = true
                timezonePicker.delegate = self
                timezonePicker.dataSource = self
                timezoneView.addSubview(timezonePicker)
                
                cell.contentView.addSubview(timezoneView)
            default:
                break
            }
            return cell
        }
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
