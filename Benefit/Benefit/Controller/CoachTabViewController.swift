//
//  CoachTabViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 31/05/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class CoachTabViewController: UIViewController, SegueProtocol{
    func coachSegue() {
       print("Nothing")
    }
    func notificationSegue() {
        performSegue(withIdentifier: "toNotifFromCoach", sender: self)
    }
    func menuSegue() {
        performSegue(withIdentifier: "toSelectFromCoach", sender: self)
        
    }
    func homeSegue() {
        performSegue(withIdentifier: "toHomeFromCoach", sender: self)
    
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
        tabBarView.coachButtonPressed((Any).self)
        

    }
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func chatButtonPressed(_ sender: Any) {
        displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
    }
    
    

}
