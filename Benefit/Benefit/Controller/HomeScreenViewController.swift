//
//  HomeScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 21/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import SideMenu
import JTHamburgerButton

class HomeScreenViewController: UIViewController, SegueProtocol{
    func coachSegue() {
        performSegue(withIdentifier: "toCoachTab", sender: self)
    }
    func notificationSegue() {
        performSegue(withIdentifier: "toNotificationTab", sender: self)
    }
    func menuSegue() {
        performSegue(withIdentifier: "toMenuTab", sender: self)
        
    }
    
   // var leftMenuNavController: UISideMenuNavigationController!
    
    @IBOutlet var tabBarView: TabBar!
    
    @IBOutlet var chatButtonTab: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        setupRounded(button: chatButton)
        //NavBar Image Added
        let logo = UIImage(named: "benefit_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = imageView
        tabBarView.delegate = self
        
        chatButtonTab.layer.borderColor = UIColor.white.cgColor
        chatButtonTab.layer.borderWidth = 2
        chatButtonTab.layer.cornerRadius = chatButtonTab.frame.size.width/2
        chatButtonTab.layer.masksToBounds = true
        tabBarView.homeButtonPressed((Any).self)
        
       

    }
    
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//        setupCustomNavigationBar()
//    }


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
    
    override func viewWillDisappear(_ animated: Bool)
    {
        print("Dash Disappearing")
    }
    
    
   
    
}

extension UIApplication
{
    var statusBarView: UIView?
    {
        return value(forKey: "statusBar") as? UIView
    }
}

//extension UIViewController: MyNavigationBarDelegate, UISideMenuNavigationControllerDelegate
//{
//    func setupCustomNavigationBar()
//    {
//        let navBar = NavBar()
//        //self.navigationItem.hidesBackButton = true
//        navBar.frame = (self.navigationController?.navigationBar.frame)!
//        let height = (self.navigationController?.navigationBar.frame.height)!
//        let width = (self.navigationController?.navigationBar.frame.width)!
//
//        UIApplication.shared.keyWindow?.addSubview(navBar)
//
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor(hex: "FAFAFA")
//
//        let heightConstraint = NSLayoutConstraint(item: navBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
//        let widthConstraint = NSLayoutConstraint(item: navBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
//        navBar.addConstraints([heightConstraint, widthConstraint])
//        navBar.delegate = self
//        setupSideBarMenu()
//    }
//
//    func setupSideBarMenu()
//    {
//        SideMenuManager.default.menuPresentMode = .menuSlideIn
//    }
//
//    func hamButtonWasTriggered()
//    {
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let VC = storyboard.instantiateViewController(withIdentifier: "LeftSideBar")
//        parent?.present(VC, animated: true, completion: nil)
//    }
//
//    func hamButtonWasDismissed()
//    {
//
//    }
//}

