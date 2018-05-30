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
    let itemsList = ["PremiumFeatureCell", "CalendarCell", "TodaysWorkout", "TotalWorkout", "WorkoutDescription", "WorkoutInfo", "Exercise"]
    let numberOfExercises = 6
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    let scrollViewContentWidth = UIScreen.main.bounds.width
    var isRestDay = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
        registerCellNib(named: "PremiumFeatureCell", with: tableView)
        registerCellNib(named: "WorkoutDescription", with: tableView)
        registerCellNib(named: "WorkoutInfo", with: tableView)
        registerCellNib(named: "Exercise", with: tableView)
        registerCellNib(named: "RestDayCell", with: tableView)

    }


}

extension MyWorkoutsScreenViewController: CalendarViewControllerDelegate
{
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
        if dayNumber % 7 == 0
        {
            isRestDay = true
            tableView.reloadData()
        }
        else
        {
            isRestDay = false
            tableView.reloadData()
        }
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
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.lockImageView.image = UIImage()
            cell.titleLabel.textColor = UIColor.black
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
            let calendarView = cell.contentView.viewWithTag(13) as! MyCalendar
            calendarView.delegateForHandlingDates = self
            cell.selectionStyle = .none
        }
        else if indexPath.section <= 5
        {
            if isRestDay
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "RestDayCell", for: indexPath)
            }
            else
            {
                cell = tableView.dequeueReusableCell(withIdentifier: itemsList[indexPath.section], for: indexPath)
            }
            
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: itemsList.last!, for: indexPath)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if isRestDay
        {
            return 3
        }
        else
        {
            return itemsList.count + numberOfExercises - 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 6
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
