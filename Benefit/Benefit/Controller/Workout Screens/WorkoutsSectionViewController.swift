//
//  WorkoutsSectionViewController.swift
//  Benefit
//
//  Created by Delta One on 24/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class WorkoutsSectionViewController: UIViewController
{
    var isMyWorkoutsLocked = false
    let imageList = ["fw1.png", "fw2.png", "fw3.png", "fw4.png"]
    let workoutList = ["PremiumFeatureCell", "SecondaryCell", "CardViewCell"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setNav()
        for workout in workoutList
        {
            registerCellNib(named: workout, with: tableView)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.clear
        let logo = UIImage(named: "benefit_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = imageView
    }
    

}

extension WorkoutsSectionViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            if isMyWorkoutsLocked
            {
                performSegue(withIdentifier: "goToMyWorkoutsLocked", sender: self)
            }
            else
            {
                performSegue(withIdentifier: "goToMyWorkouts", sender: self)
            }
        }
        else if indexPath.section == 2
        {
            performSegue(withIdentifier: "goToHIIT", sender: self)
        }
    }  
}

extension UIViewController
{
    func registerCellNib(named name: String, with tableView: UITableView)
    {
        let cellNib = UINib(nibName: name, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: name)
    }
}

extension WorkoutsSectionViewController: UITableViewDataSource
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
        return workoutList.count - 1 + imageList.count
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
            cell.leftLogoImageView.image = UIImage(named: "ic_my_workout_24dp.png")
            cell.lockImageView.image = UIImage(named: "ic_locked_24dp.png")
            cell.titleLabel.text = "MY WORKOUTS"
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell", for: indexPath)
            return cell
        }
        else
        {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardViewCell
            cell.cardViewImage.image = UIImage(named: imageList[indexPath.section - 2])
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
       
    }


}

