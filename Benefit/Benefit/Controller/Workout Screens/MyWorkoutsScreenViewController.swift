//
//  MyWorkoutsScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 28/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class MyWorkoutsScreenViewController: UIViewController
{

    @IBOutlet weak var tableView: UITableView!
    let itemsList = ["TodaysWorkout", "TotalWorkout", "WorkoutDescription", "WorkoutInfo", "Exercise"]
    let numberOfExercises = 6
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNav()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCellNib(named: "WorkoutDescription", with: tableView)
        registerCellNib(named: "WorkoutInfo", with: tableView)
        registerCellNib(named: "Exercise", with: tableView)
        navigationItem.hidesBackButton = true

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
}

extension MyWorkoutsScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyWorkoutsScreenViewController: UITableViewDataSource
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
            cell = tableView.dequeueReusableCell(withIdentifier: itemsList[indexPath.section], for: indexPath)
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
}
