//
//  menu.swift
//  custom_menu
//
//  Created by Wilbur on 2015/06/01.
//  Copyright (c) 2015 Wilbur. All rights reserved.
//

import UIKit

class menu: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBAction func selectItem(sender: AnyObject) {
        
        let buttonTag = sender.tag
        
        switch buttonTag {
            
        case 1:
            UberSideBar.swopViewControllers(Identifier: "category_nav")
            break

        default:
            UberSideBar.swopViewControllers(Identifier: "SB_contacts_nav")
            break
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        button.transform = CGAffineTransformMakeScale(0.1, 0.1)
        button2.transform = CGAffineTransformMakeScale(0.1, 0.1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(2.0, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 8.0, options: UIViewAnimationOptions.AllowUserInteraction, animations:  {
                self.button.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 2.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.AllowUserInteraction, animations:  {
            self.button2.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
}
