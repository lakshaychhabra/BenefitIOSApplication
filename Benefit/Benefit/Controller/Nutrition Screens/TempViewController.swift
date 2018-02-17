//
//  TempViewController.swift
//  Benefit
//
//  Created by Delta One on 17/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class TempViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    let rows = ["PremiumFeatureCell", "CalendarCell", "TodaysNutritionPlan", "NutritionDiet", "CommentCell"]
    let mealBackgroundColors = [UIColor(hex: "E0A662"), UIColor(hex: "73C997"), UIColor(hex: "457B97"), UIColor(hex: "C64A4D"), UIColor(hex: "2A373E")]
    let meals = ["Breakfast", "Mid-morning", "Lunch", "Snacks", "Dinner"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView()
    {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        for row in rows
        {
            if row != "CalendarCell" && row != "TodaysNutritionPlan"
            {
                registerCellNib(named: row, with: tableView)
            }
            
        }
    }
}

extension TempViewController: CalendarViewControllerDelegate
{
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
    }
}

extension TempViewController: UITableViewDataSource, NutritionDietDelegate, CommentMealDelegate
{
    func saveButtonPressed()
    {
        saveMeal()
    }
    
    func saveMeal()
    {
        updateSaveSectionUI()
    }
    
    func updateSaveSectionUI()
    {
        
    }
    
    func commentMealTextViewDidBeginEditing()
    {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return rows.count + meals.count - 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section <= 2
        {
            return 1
        }
        else
        {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = #imageLiteral(resourceName: "ic_my_nutrition_24dp")
            cell.lockImageView.image = UIImage()
            cell.titleLabel.textColor = UIColor.black
            cell.titleLabel.text = "MY NUTRITION PLAN"
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
            let calendarView = cell.contentView.viewWithTag(13) as! MyCalendar
            calendarView.delegateForHandlingDates = self
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodaysNutritionPlan", for: indexPath)
            return cell
        }
        else
        {
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionDiet", for: indexPath) as! NutritionDiet
                cell.mealName.text = meals[indexPath.section - 2]
                cell.mealPlanBackgroundView.backgroundColor = mealBackgroundColors[indexPath.section - 2]
                cell.selectionStyle = .none
                //currentSection = indexPath.section
                cell.delegate = self
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
                cell.delegate = self
                return cell
            }
        }
    }
}
