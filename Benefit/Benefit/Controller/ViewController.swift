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
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(hex: "FAFAFA")
        let customNavigationBar = NavBar()
        customNavigationBar.frame = navigationController!.navigationBar.frame
    navigationController?.navigationBar.addSubview(customNavigationBar)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

   

}
