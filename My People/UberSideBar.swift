//
//  ContainerView.swift
//  custom_menu
//
//  Created by Wilbur on 2015/06/01.
//  Copyright (c) 2015 Wilbur. All rights reserved.
//

import UIKit

let UberSideBar: ContainerView = ContainerView()

class ContainerView: UIViewController {
    
    /**
        The name of you main storyboard
    
        Defaults to 'Main' if nothing is supplied 
    
        :param: String StoryboardName
        :returns: Void
    */
    var mainStoryBoardName:String!
    
    /**
        The ID of the left menu display
    
        :param: String StoryboardID
        :returns: Void
    */
    var leftMenuStoryBoardID:String!
    
    /**
        The ID of the first screen you want to show for the menu
        
        :param: String StoryboardID
        :returns: Void
    */
    var mainScreenStoryBoardID:String!

    /**
        Shows and hides the sidebar shadow
    
        0 -> No shadow
    
        0.60 -> Is the default value if nothing is supplied
    
        :param: Float 0.0 - 1.0
        :returns: Void
    */
    var shadowOpacity:Float!
    
    /**
        Sets the with of the open sidebar
        
        250.0 -> Is the default value if nothing is supplied
    
        :param: CGFloat
        :returns: Void
    */
    var sidebarExpandedWidth:CGFloat!
    
    //  Private properties
    private var openingAnimationDuration:NSTimeInterval!
    private var openingSpringWithDamping:CGFloat!
    private var openingInitialSpringVelocity:CGFloat!
    private var closingAnimationDuration:NSTimeInterval!
    private var closingSpringWithDamping:CGFloat!
    private var closingInitialSpringVelocity:CGFloat!
    private var mainStoryBoard:UIStoryboard!
    private var mainView:UIViewController!
    private var leftMenu:UIViewController!
    private var slideShadowOpacity:Float!
    private var sidebarWidth:CGFloat!
    
    var state:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Set System Defaults
        if let shadow = shadowOpacity {
            slideShadowOpacity = shadow
        }else{
            slideShadowOpacity = 0.60
        }

        if let tmpSidebarWidth = sidebarExpandedWidth {
            sidebarWidth = tmpSidebarWidth
        }else{
            sidebarWidth = 200.0
        }
        
        if let storyboardName = mainStoryBoardName {
            mainStoryBoard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        }else{
            mainStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        }
        
        mainView = mainStoryBoard.instantiateViewControllerWithIdentifier(mainScreenStoryBoardID) as! UIViewController
        mainView.view.layer.shadowOpacity = slideShadowOpacity
        view.addSubview(mainView.view)
        addChildViewController(mainView)
        
        setLeftMenu(Identifier: leftMenuStoryBoardID)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func openingAnimationSettings(#AnimationDuration:NSTimeInterval, SpringWithDamping:CGFloat, InitialSpringVelocity:CGFloat) {
        openingAnimationDuration = AnimationDuration
        openingSpringWithDamping = SpringWithDamping
        openingInitialSpringVelocity = InitialSpringVelocity
    }
    
    func closingAnimationSettings(#AnimationDuration:NSTimeInterval, SpringWithDamping:CGFloat, InitialSpringVelocity:CGFloat) {
        closingAnimationDuration = AnimationDuration
        closingSpringWithDamping = SpringWithDamping
        closingInitialSpringVelocity = InitialSpringVelocity
    }
    
    func setLeftMenu(Identifier identifier:String) {
        leftMenu = mainStoryBoard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        view.insertSubview(leftMenu.view, atIndex: 0)
        addChildViewController(leftMenu)
        
        leftMenu.view.frame.origin.x = -100.0
    }
    
    func swopViewControllers(Identifier identifier:String) {
        
        mainView.view.removeFromSuperview()
        mainView = mainStoryBoard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController

        if state == 1 {
            mainView.view.frame.origin.x = sidebarWidth
        }else{
            mainView.view.frame.origin.x = 0.0
        }

        mainView.view.layer.shadowOpacity = slideShadowOpacity
        view.addSubview(mainView.view)
        
        addChildViewController(mainView)
        
        if state == 1 {
            toggleWindow()
        }
        
    }
    
    func toggleWindow() {
        
        if state == 0 {
            state = 1

            openingAnimationValues()
            
            
            UIView.animateWithDuration(openingAnimationDuration, delay: 0, usingSpringWithDamping: openingSpringWithDamping, initialSpringVelocity: openingInitialSpringVelocity, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.mainView.view.frame.origin.x = self.sidebarWidth
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: nil, animations: {
                self.leftMenu.view.frame.origin.x = 0.0
                }, completion: nil)
        }else{
            state = 0
            
            closingAnimationValues()
            UIView.animateWithDuration(closingAnimationDuration, delay: 0, usingSpringWithDamping: closingSpringWithDamping, initialSpringVelocity: closingInitialSpringVelocity, options: nil, animations: {
                self.mainView.view.frame.origin.x = 0.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: nil, animations: {
                self.leftMenu.view.frame.origin.x = -100.0
                }, completion: nil)

        }
        
    
    }
    
    private func openingAnimationValues() {
        
        /**
            Sets the default values for the opening animation 
            If none was supplied by the user
        */
        
        if openingAnimationDuration == nil {
            openingAnimationDuration = 0.50
        }
        
        if openingInitialSpringVelocity == nil {
            openingInitialSpringVelocity = 0.80
        }
        
        if openingSpringWithDamping == nil {
            openingSpringWithDamping = 0.80
        }
    }
    
    private func closingAnimationValues() {
        
        /**
            Sets the default values for the closing animation
            If none was supplied by the user
        */

        if closingAnimationDuration == nil {
            closingAnimationDuration = 0.20
        }
        
        if closingInitialSpringVelocity == nil {
            closingInitialSpringVelocity = 1.0
        }
        
        if closingSpringWithDamping == nil {
            closingSpringWithDamping = 1.0
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
