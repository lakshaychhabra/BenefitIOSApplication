//
//  SelectMenuViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 31/05/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class SelectMenuViewController: UIViewController, SegueProtocol{
    func coachSegue() {
        performSegue(withIdentifier: "toCoachFromSelect", sender: self)
    }
    func notificationSegue() {
        performSegue(withIdentifier: "toNotifFromSelect", sender: self)
    }
    func menuSegue() {
        print("at Select menu")
        
    }
    func homeSegue() {
        performSegue(withIdentifier: "toHomeFromSelect", sender: self)
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
        tabBarView.menuButtonPressed((Any).self)
    
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
    
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
        displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
    }
    

}
