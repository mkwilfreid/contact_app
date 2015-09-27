//
//  ColorManager.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/25.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit

class ManageColor {
    
        func setColor(color: String) -> UIColor {

                switch color {
                    case "Yellow":
                        return UIColor.yellowColor()
                    case "Green":
                        return UIColor.greenColor()
                    case "Blue":
                        return UIColor.blueColor()
                    case "White":
                        return UIColor.whiteColor()
                    case "Orange":
                        return UIColor.orangeColor()
                    case "Black":
                        return UIColor.blackColor()
                    case "Red":
                        return UIColor.redColor()
                    default:
                        return UIColor.whiteColor()
                    
                }
        }
}


