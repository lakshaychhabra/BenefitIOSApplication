//
//  MyWorkoutsScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 28/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class MyWorkoutsScreenViewController: UIViewController
{


    @IBOutlet weak var tableView: UITableView!
    let itemsList = ["PremiumFeatureCell", "CalendarCell", "TodaysWorkout", "TotalWorkout", "WorkoutDescription", "WorkoutInfo", "Exercise"]
    var numberOfExercises = 0
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    let scrollViewContentWidth = UIScreen.main.bounds.width
    var isRestDay = false
    
    
    var exerciseNameArray = [String]()
    var exerciseID = [String]()
    var timeTaken = [String]()
    var reps = [String]()
    var monthNumber : String = "00"
    let dateFormatter = DateFormatter()
    var dateSelected : String = ""
    let tok = ["Authorization" : LoginScreenViewController.token]
    
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
        
        
        navigationBarLogo()
        
        
        let todaysDate = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateSelected = dateFormatter.string(from: todaysDate)
        print(dateSelected)
        configuringTableViews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeInDate(_:)), name: NSNotification.Name(rawValue: "newDate"), object: nil)
        
    }
    
    @objc func changeInDate(_ notification: NSNotification){
        
        configuringTableViews()
        
    }
    
    func navigationBarLogo(){
        
        let logo = UIImage(named: "benefit_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = imageView
    }
    
    func configuringTableViews(){
        
        let exerciseUrl = "http://13.59.14.56:5000/api/v1/workout/user/get?date=\(dateSelected)"
        
        Alamofire.request(exerciseUrl, method: .get, headers: tok).responseJSON { (response) in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                if data["data"] == JSON.null {
                    print("No Data for the day")
                    self.numberOfExercises = 0
                    self.tableView.reloadData()
                }
                else {
                    let exercises = data["data"]["workout"]["exercises"]
                    var i = 0
                    var exerciseId = String()
                    var reps = String()
                    var timeTaken = String()
                    var exerciseName = String()
                    
                    print(data["data"]["workout"]["exercises"], exercises.count)
                    
                    while i < exercises.count {
                        
                        exerciseId = exercises[i]["exercise"]["_id"].rawString()!
                        reps = exercises[i]["exercise"]["reps"].rawString()!
                        timeTaken = exercises[i]["exercise"]["timeTaken"].rawString()!
                        exerciseName = exercises[i]["exercise"]["name"].rawString()!
                        
                        self.exerciseID.append(exerciseId)
                        self.reps.append(reps)
                        self.timeTaken.append(timeTaken)
                        self.exerciseNameArray.append(exerciseName)
                        
                        i += 1
                    }
                    
                    print(self.exerciseNameArray, self.exerciseID)
                    self.numberOfExercises = self.exerciseID.count
                    self.tableView.reloadData()
                }
            }
        }
        
    }

}

extension MyWorkoutsScreenViewController: CalendarViewControllerDelegate
{
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
//        if dayNumber % 7 == 0
//        {
//            isRestDay = true
//            tableView.reloadData()
//        }
//        else
//        {
//            isRestDay = false
//            tableView.reloadData()
//        }
        
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        
        switch month {
        case months[0]:
            monthNumber = "01"
        case months[1]:
            monthNumber = "02"
        case months[2]:
            monthNumber = "03"
        case months[3]:
            monthNumber = "04"
        case months[4]:
            monthNumber = "05"
        case months[5]:
            monthNumber = "06"
        case months[6]:
            monthNumber = "07"
        case months[7]:
            monthNumber = "08"
        case months[8]:
            monthNumber = "09"
        case months[9]:
            monthNumber = "10"
        case months[10]:
            monthNumber = "11"
        case months[11]:
            monthNumber = "12"
        default:
            print("Nooo")
        }
        dateSelected = "\(dayNumber)-\(monthNumber)-\(year)"
        let dateNotif : [String : String] = ["date" : dateSelected]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDate"), object: nil, userInfo: dateNotif)
        
        print(dateSelected)
        
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
        if section < 6 {
        return 1
        }
        else {
            return numberOfExercises
        }
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
