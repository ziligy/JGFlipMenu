//
//  TutorialViewController.swift
//  JGFlipMenu
//
//  Created by Jeff on 12/28/14.
//  Copyright (c) 2014 Jeff Greenberg. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
