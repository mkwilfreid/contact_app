//
//  CategoryTableViewController.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/22.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{

    // MARK: - Properties
     let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
     var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    // MARK: - Actions
    @IBAction func toggleMe(sender: AnyObject) {
        UberSideBar.toggleWindow()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRow!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryTableViewCell
        let category = fetchedResultController.objectAtIndexPath(indexPath) as! Category
        println(category.name)
        cell.nameLabel?.text = category.name.capitalizedString
        cell.colorPicked.backgroundColor = ManageColor().setColor(category.color as! String)
        //ell.colorPicked.backgroundColor = category.color
        println("\(category.color)")
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject: NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        context?.deleteObject(managedObject)
        context?.save(nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         performSegueWithIdentifier("editCategory", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editCategory" {
            let indexPath = tableView.indexPathForSelectedRow()
            let destinationVC: NewCategory = segue.destinationViewController as! NewCategory
            let category:Category = fetchedResultController.objectAtIndexPath(indexPath!) as! Category
            destinationVC.category = category

        }
    }
    
    // Custom functions
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: categoryFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func categoryFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        println(fetchRequest)
        return fetchRequest
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        // Refresh tableview to fetch all data
        tableView.reloadData()
    }
    
}
