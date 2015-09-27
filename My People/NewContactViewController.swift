//
//  NewCategoryViewController.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/22.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class NewContactViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - Properties
    var contact: Contact?
    var categories: Category?
    var newPic:Bool = false
    
    // initialize the core data context:
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // MARK: - Outlets
    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    
    // MARK: - Actions
    @IBAction func savebtn(sender: AnyObject) {
        
        let entity = NSEntityDescription.entityForName("Contact", inManagedObjectContext: context!)
        let newContact = Contact(entity: entity!, insertIntoManagedObjectContext: context)
            newContact.name = nameField.text
            newContact.email = emailField.text
            newContact.phone = phoneField.text
        let categoryEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: context!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = categoryEntity!
        fetchRequest.predicate = NSPredicate(format:"name == %@",categoryField.text)
        if let fetchResults = {
            
        }
        if let results = fetchResults {
            var requiredCategory : Category
            if (results.count > 0) {
                requiredCategory = results[0] as! Category
            } else {
                requiredCategory = Category(entity: categoryEntity!, insertIntoManagedObjectContext: context!)
                requiredCategory.name = categoryField.text
                // set the other properties for the Category as necessary
            }
            newContact.category = requiredCategory
        }
            newContact.photo = UIImageJPEGRepresentation(imageHolder.image, 1)
        
        var error: NSError?
                
        context?.save(&error)
        
        if let errorSaving = error {
            var alert = UIAlertController(title: "Alert", message: "Couldn't save contact !!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            nameField.text = ""
            emailField.text = ""
            phoneField.text = ""
            imageHolder.image = UIImage(named: "placeholder-person.jpg")
            var alert = UIAlertController(title: "Notification", message: "Contact added", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
     @IBAction func imageHolderTaped(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as NSString]
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newPic = true
        }
        print("Select pic")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        
        if let contact = contact {
            self.title = contact.name
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneEditing:")
            nameField.text = contact.name
            emailField.text = contact.email
            phoneField.text = contact.phone
            imageHolder.image = UIImage(data: contact.photo)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneEditing(sender: UIBarButtonItem) {
        if contact != nil {
            editContact()
        }
        dismissController()
    }
    
    
    func dismissController() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func editContact() {
        contact?.name = nameField.text
        contact?.phone = phoneField.text
        contact?.email = emailField.text
        contact?.photo = UIImageJPEGRepresentation(imageHolder.image, 1)
        context?.save(nil)
        var alert = UIAlertController(title: "Notification", message: "Contact edited", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func createContact() {
//        let entity =
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //        if mediaType.isEqualToString(kUTTypeImage as! String) {
        if let imageType = kUTTypeImage as? String where imageType == mediaType {
            // do something
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            imageHolder.image = image
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, context: UnsafePointer<Void>) {
        if error != nil {
            let alert = UIAlertController(title: "Save Failed", message: "Failed t0 save image", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func roudningImage(picture: UIImageView) {
        picture.layer.borderWidth = 2
        picture.layer.masksToBounds = false
        picture.layer.borderColor = UIColor.yellowColor().CGColor
        picture.layer.cornerRadius = picture.frame.height/2
        picture.clipsToBounds = true
    }
    
    func styleUI() {
        self.imageHolder.layer.cornerRadius = self.imageHolder.frame.size.width / 2
        self.imageHolder.clipsToBounds = true
        self.imageHolder.layer.borderWidth = 2
        self.imageHolder.layer.borderColor = UIColor.orangeColor().CGColor
    }
}
