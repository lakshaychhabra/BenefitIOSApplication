//
//  WaterIntakeViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class MealLogViewController: UIViewController, CalendarViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate
{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dinnerTableView: UITableView!
    @IBOutlet var snacksTableView: UITableView!
    @IBOutlet var lunchTableView: UITableView!
    @IBOutlet var midbreakfastTableView: UITableView!
    @IBOutlet var breakfastTableView: UITableView!
    
    // POP UP IBOUTLETS
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mealsDishLabel: UILabel!
    @IBOutlet var mealsNumberLabel: UILabel!
    @IBOutlet var pickerViewNumber: UIPickerView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var searchTableView: UITableView!
    
    // ~~~~~~~All Locally Defined Variables~~~~~~~~~
    
    var mealsDish = ["eggs", "Juice", "Rotis", "Bananas", "Glass of Juice", "Samosa", "Chappatis", "Oats", "Chicken Wings", "Mix Veg", "Salad Plate", "Fruit Salad"]
    var mealNumber = ["1", "2", "3", "4", "5", "6", "7"]
    var completedString = ""
    var filteredData = [String]()
    var isSearching = false
    var breakfast = [String]()
    var midBreakfast = [String]()
    var lunch = [String]()
    var snacks = [String]()
    var dinner = [String]()
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.popUpView.center.x = self.view.center.x
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 2.0)
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        mealsNumberLabel.textAlignment = .center
        popUpView.layer.cornerRadius = 10
        self.searchTableView.backgroundColor = UIColor(hex: "EEEEEE")
        searchBar.returnKeyType = .done
       //here
        
        
    }
    
    func popUpSetup(){
        self.view.addSubview(popUpView)
        self.popUpView.center.x = self.view.center.x
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 20.0)
    }
    
    
    @IBAction func addMoreButtonClicked(_ sender: UIButton) {
        popUpSetup()
        tag = sender.tag
    }
    //~~~~~~~~~~Picker View Configuration~~~~~~~~~~~~~~~
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return mealNumber.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return mealNumber[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        mealsNumberLabel.text = mealNumber[row]
        
    }
    // ~~~~~~~~~~~PickerView ENDS~~~~~~~~~~~~~~
    
    @IBAction func saveFromPopUp(_ sender: UIButton) {
        
        completedString =  mealsNumberLabel.text! + " \(mealsDishLabel.text!)"
        print(completedString)
        
       
        if mealsNumberLabel.text == "" || mealsDishLabel.text == "" {
            //do nothing
            print("empty")
        }
        else{
        
            if tag == 0{
                breakfast.append(completedString)
                print(breakfast)
                breakfastTableView.reloadData()
            }
            if tag == 1{
                midBreakfast.append(completedString)
                print(midBreakfast)
                midbreakfastTableView.reloadData()
            }
            if tag == 2{
                lunch.append(completedString)
                lunchTableView.reloadData()
            }
            if tag == 3{
                snacks.append(completedString)
                snacksTableView.reloadData()
                
            }
            if tag == 4{
                dinner.append(completedString)
                dinnerTableView.reloadData()
                
                }
        }
        mealsDishLabel.text = ""
        mealsNumberLabel.text = ""
        self.popUpView.removeFromSuperview()
        
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        mealsDishLabel.text = ""
        mealsNumberLabel.text = ""
        self.popUpView.removeFromSuperview()
        
    }
    // ~~~~~~~Search BAR~~~~~~~~~~
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            searchTableView.reloadData()
        }
        else{
            isSearching = true
            filteredData = mealsDish.filter{name in
                
                return   name.lowercased().contains(searchText.lowercased())}
            searchTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    // ~~~~~~~ Setting Up Calendar ~~~~~~~~~
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        let indexPath = IndexPath(row: 0, section: 1)
        if tableView.rectForRow(at: indexPath).contains(touch.location(in: tableView.cellForRow(at: indexPath)))
        {
            
            return false
        }
        return true
    }
    
    // ~~~~~~~~~ Setting Up Table View ~~~~~~~~~
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.searchTableView {
            
            
            let cell =  searchTableView.dequeueReusableCell(withIdentifier: "cell1")//searchTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let text : String!
            if isSearching{
                text = filteredData[indexPath.row]
            }
            else{
                text = mealsDish[indexPath.row]
            }
            
            cell?.textLabel?.text = text
            return cell!
            
        }
        else if breakfast.count == 0 && tableView == self.breakfastTableView{
            
            let cell = breakfastTableView.dequeueReusableCell(withIdentifier: "breakfastCell")
            cell?.textLabel?.text = "Please Add Breakfast Dishes"
            return cell!
            
        }
         else if breakfast.count != 0 && tableView == self.breakfastTableView {
         
            
            let cell = breakfastTableView.dequeueReusableCell(withIdentifier: "breakfastCell")
            cell?.textLabel?.text = breakfast[indexPath.row]
            return cell!
            
        
        }
       else if midBreakfast.count != 0 && tableView == self.midbreakfastTableView{
            
            let cell = midbreakfastTableView.dequeueReusableCell(withIdentifier: "midbreakfastCell")
            cell?.textLabel?.text = midBreakfast[indexPath.row]
            return cell!
            
        }
        else if midBreakfast.count == 0 && tableView == self.midbreakfastTableView{
            
            let cell = midbreakfastTableView.dequeueReusableCell(withIdentifier: "midbreakfastCell")
            cell?.textLabel?.text = "Add Mid BreakFast Dishes"
            return cell!
            
        }
       else if lunch.count != 0 && tableView == self.lunchTableView{
            
            let cell = lunchTableView.dequeueReusableCell(withIdentifier: "lunchCell")
            cell?.textLabel?.text = lunch[indexPath.row]
            return cell!
        
        }
        else if lunch.count == 0 && tableView == self.lunchTableView{
            
            let cell = lunchTableView.dequeueReusableCell(withIdentifier: "lunchCell")
            cell?.textLabel?.text = "Add Lunch Dishes"
            return cell!
            
        }
        else if snacks.count != 0 && tableView == self.snacksTableView{
            
            let cell = snacksTableView.dequeueReusableCell(withIdentifier: "snacksCell")
            cell?.textLabel?.text = snacks[indexPath.row]
            return cell!
            
        }
        else if snacks.count == 0 && tableView == self.snacksTableView{
            
            let cell = snacksTableView.dequeueReusableCell(withIdentifier: "snacksCell")
            cell?.textLabel?.text = "Add Snacks Dishes"
            return cell!
            
        }
       else if dinner.count != 0 && tableView == self.dinnerTableView{
            
            let cell = dinnerTableView.dequeueReusableCell(withIdentifier: "dinnerCell")
            cell?.textLabel?.text = dinner[indexPath.row]
            return cell!
            
        }
        else if dinner.count == 0 && tableView == self.dinnerTableView{
            
            let cell = dinnerTableView.dequeueReusableCell(withIdentifier: "dinnerCell")
            cell?.textLabel?.text = "Add Dinner Dishes"
            return cell!
            
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
            let calendarView = cell.contentView.viewWithTag(13) as! MyCalendar
            calendarView.delegateForHandlingDates = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        if tableView == self.tableView
        {
            count = 1
            
        }
        else if tableView == self.searchTableView {
            
            if isSearching {
                
                count = filteredData.count
            }
            else{
                count = mealsDish.count
            }
            
            print(count!)
        }
        else if tableView == self.breakfastTableView{
            count = max(breakfast.count,1)
        }
        else if tableView == self.midbreakfastTableView{
            count = max(midBreakfast.count,1)
        }
        else if tableView == self.lunchTableView{
            count = max(lunch.count,1)
        }
        else if tableView == self.snacksTableView{
            count = max(snacks.count,1)
        }
        else if tableView == self.dinnerTableView{
            count = max(dinner.count,1)
        }
        
        return count!
    }
    
    // ~~~~~~~~ Search Table View Functions ~~~~~~~~
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.searchTableView {
            
            print(mealsDish[indexPath.row])
            if isSearching {
                mealsDishLabel.text = filteredData[indexPath.row]
            }
            else {
                
                mealsDishLabel.text = mealsDish[indexPath.row]
            }
            
        }
    }
    
    // ~~~~~~~~~~ Appearance of Search Table View ~~~~~~~~~~
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.searchTableView {
            cell.backgroundColor = UIColor.clear
        }
    }

   
}
