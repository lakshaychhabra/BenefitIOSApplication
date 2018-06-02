//
//  MyWorkoutsLockedScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 28/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class MyWorkoutsLockedScreenViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setNav()
        //navigationItem.hidesBackButton = true
        let logo = UIImage(named: "benefit_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = imageView
    }


}
