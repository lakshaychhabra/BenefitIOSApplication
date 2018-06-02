//
//  NutritionArticleScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 02/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class NutritionArticleScreenViewController: UIViewController, SegueProtocol{
    func coachSegue() {
        //performSegue(withIdentifier: "toCoachTab", sender: self)
       
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "coachViewController") as! CoachTabViewController
                
           self.present(newViewController, animated: true, completion: nil)
    }
    func notificationSegue() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "notifiViewController") as! NotificationTabViewController
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    func menuSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! SelectMenuViewController
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    func homeSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)

        
    }

    
    let cellList = ["ArticleTitle", "FullSizedImageViewCell", "ShareArticle", "NutritionArticleViewCell"]
    
    @IBOutlet var tabBarView: TabBar!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCellNib(named: "FullSizedImageViewCell", with: tableView)
        registerCellNib(named: "NutritionArticleViewCell", with: tableView)
        tabBarView.delegate = self
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 2
        chatButton.layer.cornerRadius = chatButton.frame.size.width/2
        chatButton.layer.masksToBounds = true
        tabBarView.buttonPressed(UIButton.self())
        
        
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
         displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
        
    }
    
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension NutritionArticleScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellList[indexPath.section], for: indexPath) as! FullSizedImageViewCell
            cell.croppedImage.image = UIImage(named: "fn1cropped.png")
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellList[indexPath.section], for: indexPath)
            if indexPath.section == 3
            {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0)
            }
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return cellList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
}

extension NutritionArticleScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
