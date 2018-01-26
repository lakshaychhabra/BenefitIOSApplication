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

extension UIViewController
{
    func setupCustomNavBar()
    {
        let customNavigationBar = NavBar()
        customNavigationBar.frame = navigationController!.navigationBar.frame
        navigationController?.navigationBar.addSubview(customNavigationBar)
        customNavigationBar.coachButton.addTarget(self, action: #selector(coachButtonPressed), for: .touchUpInside)
        customNavigationBar.hamButton.addTarget(self, action: #selector(hamburgerMenuButtonPressed), for: .touchUpInside)
       
    }
    
    @objc func hamburgerMenuButtonPressed(sender: UIButton)
    {
        print("Hamburger Menu Button Pressed")
        
//        if !isHamburgerMenuToggled
//        {
//            isHamburgerMenuToggled = true
//            mainViewLeadingConstraint.constant = 150
//            mainViewTrailingConstraint.constant = -150
//        }
//        else
//        {
//            isHamburgerMenuToggled = false
//            mainViewTrailingConstraint.constant = 0
//            mainViewLeadingConstraint.constant = 0
//        }
//
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {self.view.layoutIfNeeded()})
//        {
//            (animationComplete) in
//            print("animation complete!")
//        }
        
        
    }
    
    @objc func coachButtonPressed(sender: UIButton)
    {
        print("Coach Button Pressed")
    }

}
