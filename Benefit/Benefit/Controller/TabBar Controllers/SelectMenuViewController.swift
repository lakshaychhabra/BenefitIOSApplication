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
        //performSegue(withIdentifier: "toCoachTab", sender: self)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "coachViewController") as! CoachTabViewController
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    func notificationSegue() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "notifiViewController") as! NotificationTabViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        
    }
    func menuSegue() {
       print("menu Module")
        
    }
    func homeSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
        
        
    }

    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabBarView: TabBar!
    @IBOutlet var chatButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarView.delegate = self
        
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 2
        chatButton.layer.cornerRadius = chatButton.frame.size.width/2
        chatButton.layer.masksToBounds = true
       // tabBarView.menuButtonPressed((Any).self)
        addNavBarImage()
        tabBarView.buttonPressed(UIButton.self())
        tabBarView.menuButtonPressed()
        
        registerCellNib(named: "PremiumFeatureCell", with: tableView)
    
    }

    
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
        
        displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "chats") as! ChatViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func addNavBarImage() {
        
        
        let image = UIImage(named: "benefit_logo") //Your logo url here
        let imageView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        imageView.image = image
        
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor.init(hex: "f2f2f2")
    }
    

}


extension SelectMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell") as! PremiumFeatureCell
            cell.titleLabel.text = "DashBoard"
            cell.lockImageView.isHidden = true
             return cell
            
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell") as! PremiumFeatureCell
            cell.titleLabel.text = "Profile"
            cell.lockImageView.isHidden = true
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell") as! PremiumFeatureCell
            cell.titleLabel.text = "Logout"
            cell.lockImageView.isHidden = true
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            
            UserDefaults.standard.set(false, forKey: "UserAlreadyLoggedIn")
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.synchronize()
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "StartupScreens", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "startup") as! StartupScreenViewController
            self.present(newViewController, animated: true, completion: nil)
            
        }
    }
    
    
    
}
