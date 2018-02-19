//
//  ViewController.swift
//  Benefit
//
//  Created by Delta One on 23/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

var isHamburgerMenuToggled = false

class ViewController: UIViewController
{

    @IBOutlet weak var mainViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCustomNavBar()
    }
    

}


