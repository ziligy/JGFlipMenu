//
//  JGFlipMenuController
//  JGFlipMenu
//
//  Created by Jeff on 12/22/14.
//  Copyright (c) 2014 Jeff Greenberg. All rights reserved.
//

import UIKit

class JGFlipMenuController: UIViewController, UINavigationControllerDelegate, JGFlipMenuItemDelegate {
    
    private var menuItems = [JGFlipMenuItem]()
    
    private var currentIndex: Int?
    
    private var transitionAnimation = JGTransitionExpandContract()
    
    private var mainStoryBoard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        assignDelegateAndTagSubviews(view)
        
        navigationController?.delegate = self
    }
    
    private func assignDelegateAndTagSubviews(view: UIView) {
        for subview in view.subviews as [AnyObject] {
            if let subSubView = subview as?  UIView {
                assignDelegateAndTagSubviews(subSubView)
            }
            if let menuItem = subview as? JGFlipMenuItem {
                menuItem.delegate = self 
                menuItem.tag = menuItems.endIndex // set tag to its array index
                menuItems.append(menuItem)
            }
        }
    }
    
    // JGFlipMenuItemDelegate method called when frontside of menu is selected
    internal func frontSideSelected(indexTag: Int) {
        // println("front side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
        
        // get instance using the frontSideTitle.text which MUST be the same a view controller's Storyboard ID
        if let vc = mainStoryBoard.instantiateViewControllerWithIdentifier(menuItems[indexTag].frontSideTitle.text) as? UIViewController {
            
            // convert the menu item center point that's in the  menu items container to the full view container point
            transitionAnimation.focalPoint = menuItems[indexTag].superview?.convertPoint(menuItems[indexTag].center, toView: self.view)
            
            // keep the current index for fliping the menu back when popped back
            currentIndex = indexTag

            // push the view controller onto the navigationController's stack
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // JGFlipMenuItemDelegate method called when backside of menu is selected
    internal func backSideSelected(indexTag: Int) {
        // println("back side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
    }
    
    internal func navigationController(navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            // set the transtion to isPresenting (i.e. expand) for the push
            if (operation == .Push) {
                transitionAnimation.isPresenting = true
            } else {
                // set the transtion to contract for the pop back
                transitionAnimation.isPresenting = false
            }
            
            return transitionAnimation
    }
    
    override func viewDidAppear(animated: Bool) {
        // ignore if currentIndex is nil, as when view first appears
        if let index = currentIndex? {
            // menu item is done with display so flip to the front side
            self.menuItems[index].flipToFrontSide()
        }
    }
}
