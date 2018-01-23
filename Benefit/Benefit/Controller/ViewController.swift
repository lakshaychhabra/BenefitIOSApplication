//
//  ViewController.swift
//  Benefit
//
//  Created by Delta One on 23/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let customNavigationBar = NavBar()
        customNavigationBar.frame = navigationController!.navigationBar.frame
        navigationController?.navigationBar.addSubview(customNavigationBar)
        //customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint(item: customNavigationBar, attribute: .top, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
//           NSLayoutConstraint(item: customNavigationBar, attribute: .leading, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
//           NSLayoutConstraint(item: customNavigationBar, attribute: .bottom, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
//           NSLayoutConstraint(item: customNavigationBar, attribute: .right, relatedBy: .equal, toItem: navigationController?.navigationBar, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
//        print("Nav bar: \(customNavigationBar.frame)")
        print("Original Nav bar: \(navigationController?.navigationBar.frame)")

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
