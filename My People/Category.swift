//
//  Category.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/23.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import Foundation
import CoreData

@objc (Category)
class Category: NSManagedObject {

    @NSManaged var color: AnyObject
    @NSManaged var descript: String!
    @NSManaged var name: String!
    @NSManaged var contact: NSOrderedSet

}
