//
//  JGFlipMenuController
//  JGFlipMenu
//
//  Created by Jeff on 12/22/14.
//  Copyright (c) 2014 Jeff Greenberg. All rights reserved.
//

import UIKit

class JGFlipMenuController: UIViewController, JGFlipMenuItemDelegate {

    var menuItems = [JGFlipMenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegateAndTagSubviews(view)
    }
    
    func assignDelegateAndTagSubviews(view: UIView) {
        for subview in view.subviews as [AnyObject] {
            if let subSubView = subview as?  UIView {
                assignDelegateAndTagSubviews(subSubView)
            }
            if let menuItem = subview as? JGFlipMenuItem {
                menuItem.delegate = self
                menuItem.tag = menuItems.endIndex
                menuItems.append(menuItem)
            }
        }
    }
    
    func frontSideSelected(indexTag: Int) {
        println("front side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
    }
    
    func backSideSelected(indexTag: Int) {
        println("back side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
    }
}
