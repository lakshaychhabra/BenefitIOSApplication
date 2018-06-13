//
//  TrackAndLogViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class TrackAndLogViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let imageList = ["fn1.png"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
            registerCellNib(named: "PremiumFeatureCell", with: tableView)
       
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

    }

 }
extension TrackAndLogViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            performSegue(withIdentifier: "trackMyActivity", sender: self)
        }
        else if indexPath.section == 1
        {
            performSegue(withIdentifier: "mealLog", sender: self)
        }
        else if indexPath.section == 2
        {
            performSegue(withIdentifier: "waterIntake", sender: self)
        }
    }
}

extension TrackAndLogViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "EEEEEE")
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //Number of rows
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_track_activity_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "TRACK MY ACTIVITY"
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_meal_log_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "MEAL LOG"
            return cell
        }
        else 
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_water_on_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "WATER INTAKE"
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
        
    }
    
    
}

