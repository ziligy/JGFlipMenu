//
//  TestViewController.swift
//  JGFlipMenu
//
//  Created by Evgeniy on 28.04.15.
//  Copyright (c) 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
