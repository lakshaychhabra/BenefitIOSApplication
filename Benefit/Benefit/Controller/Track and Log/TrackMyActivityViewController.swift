//
//  TrackMyActivityViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class TrackMyActivityViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let imageList = ["fn1.png"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        registerCellNib(named: "PremiumFeatureCell", with: tableView)
         registerCellNib(named: "SecondaryCell", with: tableView)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
}
extension TrackMyActivityViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2
        {
            performSegue(withIdentifier: "runningSegue", sender: self)
        }
        else if indexPath.section == 3
        {
           performSegue(withIdentifier: "runningSegue", sender: self)
        }
        else if indexPath.section == 4
        {
           performSegue(withIdentifier: "runningSegue", sender: self)
        }
        else if indexPath.section == 6
        {
            // performSegue(withIdentifier: "waterIntake", sender: self)
        }
        else if indexPath.section == 7
        {
            // performSegue(withIdentifier: "waterIntake", sender: self)
        }
        else if indexPath.section == 8
        {
            // performSegue(withIdentifier: "waterIntake", sender: self)
        }
    }
}

extension TrackMyActivityViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 1
        
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
        return 9
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
            cell.lockImageView.image = .none
            cell.titleLabel.text = "TRACK MY ACTIVITY"
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell", for: indexPath) as! SecondaryCell
            cell.secondaryLabel.text = "Most Popular"
            
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_running_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Running"
            return cell
            
        }
        else if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_walking_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Walking"
            return cell
            
        }
        else if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_cycling_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Ride"
            return cell
            
        }
        else if indexPath.section == 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell", for: indexPath) as! SecondaryCell
            cell.secondaryLabel.text = "Cardiovascular Activities"
            return cell
        }
        else if indexPath.section == 6
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_running_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Aerobics"
            return cell
            
        }
        else if indexPath.section == 7
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_walking_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Swimming"
            return cell
            
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_cycling_24dp")
            cell.lockImageView.image = UIImage(named: "ic_next_24dp")
            cell.titleLabel.text = "Skipping"
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
        
    }
    


}
