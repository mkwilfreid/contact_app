//
//  ContactsTableViewController.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/22.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{

    // MARK: - Properties
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    // MARK: - Actions
    @IBAction func toggleMe(sender: AnyObject) {
        UberSideBar.toggleWindow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = getFtechedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSection = fetchedResultController.sections?.count
        return numberOfSection!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfinASection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfinASection!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! UITableViewCell
        let contact = fetchedResultController.objectAtIndexPath(indexPath) as! Contact
        println(contact.name)
        cell.textLabel?.text = contact.name
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject: NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        context?.deleteObject(managedObject)
        context?.save(nil)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editContact", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editContact" {
           
            let indexPath = tableView.indexPathForSelectedRow()
            let destinationVC: NewContactViewController = segue.destinationViewController as! NewContactViewController
            let contact:Contact = fetchedResultController.objectAtIndexPath(indexPath!) as! Contact
            destinationVC.contact = contact

        }
    }
    
    // MARK: - Custom functions
    func getFtechedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: contactFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func contactFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        // Refresh tableview to fetch all data
        tableView.reloadData()
    }
    

}
