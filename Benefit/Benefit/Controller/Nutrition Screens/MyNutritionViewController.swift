//
//  MyNutritionViewController.swift
//  Benefit
//
//  Created by Delta One on 14/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class MyNutritionViewController: UIViewController
{
    let mealBackgroundColors = [UIColor(hex: "E0A662"), UIColor(hex: "73C997"), UIColor(hex: "457B97"), UIColor(hex: "C64A4D"), UIColor(hex: "2A373E")]
    let meals = ["Breakfast", "Mid-morning", "Lunch", "Snacks", "Dinner"]
    var currentSection = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView()
    {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        registerCellNib(named: "PremiumFeatureCell", with: tableView)
        registerCellNib(named: "NutritionDiet", with: tableView)
        registerCellNib(named: "CommentCell", with: tableView)
        hideKeyboard()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

extension MyNutritionViewController: UITableViewDataSource, NutritionDietDelegate, CommentMealDelegate
{
    func commentMealTextViewDidBeginEditing()
    {
        if currentSection < 6
        {
            let indexPath = IndexPath(row: 1, section: currentSection)
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return meals.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section >= 2
        {
            return 2
        }
        else
        {
            return 1
        }
    }
    
    @objc func keyboardWasShown(notification: NSNotification)
    {
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size

        var contentInsets:UIEdgeInsets

        if UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
        {

            contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0);
        }
        else
        {
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.width, 0.0);

        }

        tableView.contentInset = contentInsets

        if currentSection == 6
        {
            let indexPath = IndexPath(row: 1, section: currentSection)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification)
    {
        tableView.contentInset = UIEdgeInsets.zero
        tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = #imageLiteral(resourceName: "ic_my_nutrition_24dp")
            cell.lockImageView.image = UIImage()
            cell.titleLabel.textColor = UIColor.black
            cell.titleLabel.text = "MY NUTRITION PLAN"
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
            cell.selectionStyle = .none
        }
        else
        {
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionDiet", for: indexPath) as! NutritionDiet
                cell.mealName.text = meals[indexPath.section - 2]
                cell.mealPlanBackgroundView.backgroundColor = mealBackgroundColors[indexPath.section - 2]
                cell.selectionStyle = .none
                currentSection = indexPath.section
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
}

extension MyNutritionViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


