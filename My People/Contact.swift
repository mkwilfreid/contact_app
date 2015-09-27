//
//  Contact.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/23.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import Foundation
import CoreData

@objc (Contact)
class Contact: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var photo: NSData
    @NSManaged var category: Category

}
