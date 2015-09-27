//
//  NewCategory.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/25.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit
import CoreData

class NewCategory: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {

    
    // MARK: - Propertiesx
    var category: Category?
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let categoryColor = ["White","Yellow","Black","Red", "Green", "Blue"]
//    let dataCategory = [Category]()
    
    // MARK: Outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var colorLabel: UILabel!
    
    // MARK: Actions
    @IBAction func saveBtn(sender: AnyObject) {

        if name.text == "" || name.text.isEmpty || name.text.isEmpty && descriptionField.text == "" || descriptionField.text.isEmpty || descriptionField.text.isEmpty{
            var alert = UIAlertController(title: "WARNING !!!", message: "Couldn't add category. Fill all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            createCategory()
        }

    }
    
    // MARK: View settings
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.delegate = self
        self.descriptionField.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        descriptionField.text = ""
        
        if let selectedCategory = category {
            self.title = category?.name
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneEditing:")
            name.text = category?.name
            descriptionField.text = category?.descript
            colorLabel.backgroundColor = ManageColor().setColor(category?.color as! String)
            
        }

    }
    
    // Custom functions
    func createCategory() {
        let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: context!)
        let category = Category(entity: entity!, insertIntoManagedObjectContext: context)
        let index = pickerView.selectedRowInComponent(0)
        let color = categoryColor[index]
        
            category.name = name.text
            category.descript = descriptionField.text
            category.color = color
            println(category.name)
            context?.save(nil)
        name.text = ""
        descriptionField.text = ""
    }
    
    func doneEditing() {
        
    }
    
    @IBAction func doneEditing(sender: UIBarButtonItem) {
        if category != nil {
            editCategory()
        }
        dismissController()
    }
    
    func dismissController() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func editCategory() {
        let index = pickerView.selectedRowInComponent(0)
        let color = categoryColor[index]
        
        if name.text != category?.name || descriptionField.text != category?.descript{
            self.title = "Edit Category"
            
            if name.text == "" || name.text.isEmpty || name.text.isEmpty && descriptionField.text == "" || descriptionField.text.isEmpty || descriptionField.text.isEmpty{
                
                var alert = UIAlertController(title: "WARNING !!!", message: "Fill all fields.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)

            } else { // save edited fields
                category?.name = name.text
                category?.descript = descriptionField.text
                category?.color = color
                println(category?.name)
                context?.save(nil)
                var alert = UIAlertController(title: "Notification", message: "Category successfully edited", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        } else {
            
            var alert = UIAlertController(title: "FAILURE !!!!", message: "Field not  edited", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in alert.dismissViewControllerAnimated(true, completion: nil)})
                
        }
        
        //cleanFields()
    }

    func cleanFields() {
        category?.name = name.text
        category?.descript = descriptionField.text
        colorLabel.backgroundColor = UIColor.whiteColor()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryColor.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoryColor[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let colors = NSAttributedString(string: categoryColor[row], attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 10.0)!,NSForegroundColorAttributeName:UIColor.brownColor()]
        )
        return colors
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 28
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (row == 0) {
            colorLabel.backgroundColor = UIColor.whiteColor()
        }
        else if(row == 1) {
            colorLabel.backgroundColor = UIColor.yellowColor()
        }
        else if(row == 2) {
            colorLabel.backgroundColor = UIColor.blackColor()
        }
        else if(row == 3) {
            colorLabel.backgroundColor = UIColor.redColor()
        }
        else if(row == 4) {
            colorLabel.backgroundColor = UIColor.greenColor()
        }
        else {
            colorLabel.backgroundColor = UIColor.blueColor()
        }
    }
    // MARK: - DISCARD KEYBOARD
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.title = "Edit Category"
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.title = name.text
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.title = "Edit Category"
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.title = "Edit Category"
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.descriptionField.resignFirstResponder()
            return false
        }
        return true
    }
}
