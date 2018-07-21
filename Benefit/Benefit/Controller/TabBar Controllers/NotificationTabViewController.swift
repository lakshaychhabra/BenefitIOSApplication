//
//  NotificationTabViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 31/05/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class NotificationTabViewController: UIViewController, SegueProtocol{
    func coachSegue() {
        //performSegue(withIdentifier: "toCoachTab", sender: self)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "coachViewController") as! CoachTabViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    func notificationSegue() {
        
      print("At Notification")
        
    }
    func menuSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! SelectMenuViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        
    }
    func homeSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        
        
    }


    @IBOutlet var tabBarView: TabBar!
    @IBOutlet var chatButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarView.delegate = self
        
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 2
        chatButton.layer.cornerRadius = chatButton.frame.size.width/2
        chatButton.layer.masksToBounds = true
      //  tabBarView.notificationButtonPressed((Any).self)
        tabBarView.buttonPressed(UIButton.self())
        tabBarView.notificationButtonPressed()
        addNavBarImage()
        
    }

    func addNavBarImage() {
        
        
        let image = UIImage(named: "benefit_logo") //Your logo url here
        let imageView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        imageView.image = image
        
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor.init(hex: "f2f2f2")
    }

    
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "chats") as! ChatViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
        displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
    }
    
   

}
