//
//  HomeScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 21/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController
{

    @IBOutlet weak var chatButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setNav()
        let navBar = NavBar()
        navBar.frame = (self.navigationController?.navigationBar.frame)!
        UIApplication.shared.keyWindow?.addSubview(navBar)
//        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "FAFAFA")
        setupRounded(button: chatButton)

    }
    
    @IBAction func workoutsButtonPressed(_ sender: UIButton)
    {
        print("Workout")
    }
    
    @IBAction func nutritionButtonPressed(_ sender: UIButton)
    {
        print("Nutrition")
    }
    
    @IBAction func trackAndLogButtonPressed(_ sender: UIButton)
    {
        print("Track and Log")
    }
    
    
    @IBAction func measurementButtonPressed(_ sender: UIButton)
    {
        print("Measurement")
    }
    
    
    @IBAction func challengesButtonPressed(_ sender: UIButton)
    {
        print("Challenges")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

extension UIViewController
{
//    func setupCustomNavBar()
//    {
//        let customNavigationBar = NavBar()
//        customNavigationBar.frame = navigationController!.navigationBar.frame
//        navigationController?.navigationBar.addSubview(customNavigationBar)
//        customNavigationBar.coachButton.addTarget(self, action: #selector(coachButtonPressed), for: .touchUpInside)
//        customNavigationBar.hamButton.addTarget(self, action: #selector(hamburgerMenuButtonPressed), for: .touchUpInside)
//
//    }
    
    func setNav()
    {
        
        let containerTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 155, height: 34))
        let titleView = UIImageView(image: #imageLiteral(resourceName: "benefit_logo"))
        titleView.contentMode = .scaleAspectFit
        titleView.frame = CGRect(x: 0, y: 0, width: 155, height: 34)
        containerTitleView.addSubview(titleView)
        
        self.navigationItem.titleView = containerTitleView
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button.setImage(#imageLiteral(resourceName: "ic_coach_24dp-1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button2.setImage(#imageLiteral(resourceName: "ic_notif_24dp-1"), for: .normal)
        button2.imageView?.contentMode = .scaleAspectFit
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button), UIBarButtonItem(customView: button2)]
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

