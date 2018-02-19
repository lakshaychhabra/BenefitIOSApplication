//
//  HIITSingleWorkoutViewController.swift
//  Benefit
//
//  Created by Delta One on 27/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class HIITSingleWorkoutViewController: UIViewController
{
   
    @IBOutlet weak var tableView: UITableView!
    let itemsList = ["HIITBack", "FullSizedImageViewCell", "SingleWorkout", "WorkoutDescription", "WorkoutInfo", "Exercise"]
    let numberOfExercises = 6
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCellNib(named: "FullSizedImageViewCell", with: tableView)
        registerCellNib(named: "WorkoutDescription", with: tableView)
        registerCellNib(named: "WorkoutInfo", with: tableView)
        registerCellNib(named: "Exercise", with: tableView)
        tableView.tableFooterView = UIView()

    }

    
}

extension HIITSingleWorkoutViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()
        if indexPath.section >= 5
        {
            cell = tableView.dequeueReusableCell(withIdentifier: itemsList.last!, for: indexPath)
        }
        else
        {
            if indexPath.section == 1
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: itemsList[indexPath.section], for: indexPath) as! FullSizedImageViewCell
                cell.croppedImage.image = UIImage(named: "fw1cropped.png")
                return cell
                
            }
            cell = tableView.dequeueReusableCell(withIdentifier: itemsList[indexPath.section], for: indexPath)
            if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4
            {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return itemsList.count + numberOfExercises - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == itemsList.count - 1
        {
            return 15
        }
        else
        {
            return 0
        }
        
    }
}

extension HIITSingleWorkoutViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
