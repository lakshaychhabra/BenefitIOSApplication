//
//  MealLogViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Foundation

class MealLogViewController: UIViewController, SegueProtocol, UIPickerViewDelegate, UIPickerViewDataSource, MealView, UISearchBarDelegate{
    
    //Mark: - ~~~~~~~~~Delegates Method~~~~~~~~~~~`
    func callingTheView() {
        self.view.addSubview(popUpView)
        self.popUpView.center.x = self.view.center.x
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 20.0)
        
    }
    
    func finalValue() -> String {
        return completedString
    }
   
    
    func coachSegue() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "coachViewController") as! CoachTabViewController
        
        self.present(newViewController, animated: true, completion: nil)
    }
    func notificationSegue() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "notifiViewController") as! NotificationTabViewController
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    func menuSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! SelectMenuViewController
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    func homeSegue() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
        let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    
    
    //~~~~~~~~~~All Attached components IB Outlets~~~~~~~~~~~~
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var popUpView: UIView!
    @IBAction func saveFromPopUp(_ sender: UIButton) {
        
        
        completedString =  mealsNumberLabel.text! + " \(mealsDishLabel.text!)"
        print(completedString)
        
        let abcd : [String : String] = ["value" : completedString]
        if mealsNumberLabel.text == "" || mealsDishLabel.text == "" {
            //do nothing
            print("empty")
        }
        else{
        if state == 0 {
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: abcd)
          
            state += 1
        }
        else if state == 1 {
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh2"), object: nil, userInfo: abcd)
            state += 1
        }
        else if state == 2 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh3"), object: nil, userInfo: abcd)
            state += 1
        }
        else if state == 3 {
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh4"), object: nil, userInfo: abcd)
            state += 1
        }
        else {
            print("Limit exceeded")
        }
        }
        mealsDishLabel.text = ""
        mealsNumberLabel.text = ""
        self.popUpView.removeFromSuperview()
    }
   
//    @IBOutlet var mealNumberTextField: UITextField!
//    @IBOutlet var mealsDishTextField: UITextField!
    
    @IBOutlet var mealsDishLabel: UILabel!
    @IBOutlet var mealsNumberLabel: UILabel!
    @IBOutlet var pickerViewNumber: UIPickerView!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabBar: TabBar!
    @IBOutlet var searchTableView: UITableView!
    
    // ~~~~~~~All Locally Defined Variables~~~~~~~~~
    var currentSection = 0
    var mealsDish = ["eggs", "Juice", "Rotis", "Bananas", "Glass of Juice", "Samosa", "Chappatis", "Oats", "Chicken Wings", "Mix Veg", "Salad Plate", "Fruit Salad"]
    var mealNumber = ["1", "2", "3", "4", "5", "6", "7"]
    var completedString = ""
    var state = 0
    let rows = ["PremiumFeatureCell", "CalendarCell", "TodaysNutritionPlan", "Meals", "CommentCell", "SavedMealCell"]
    let mealBackgroundColors = [UIColor(hex: "E0A662"), UIColor(hex: "73C997"), UIColor(hex: "457B97"), UIColor(hex: "C64A4D"), UIColor(hex: "2A373E")]
    let meals = ["Breakfast", "Mid-morning", "Lunch", "Snacks", "Dinner"]
    var isMealSaved = [false, false, false, false, false]
    var filteredData = [String]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 2
        chatButton.layer.cornerRadius = chatButton.frame.size.width/2
        chatButton.layer.masksToBounds = true
        setupTableView()
        tabBar.delegate = self
        tabBar.buttonPressed(UIButton.self())
      
        self.popUpView.center.x = self.view.center.x
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 2.0)
        
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        
        
        mealsNumberLabel.textAlignment = .center
       
        
        popUpView.layer.cornerRadius = 10
        self.searchTableView.backgroundColor = UIColor(hex: "EEEEEE")
        searchBar.returnKeyType = .done
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
   
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    func setupTableView()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        for row in rows
        {
            if row != "CalendarCell" && row != "TodaysNutritionPlan"
            {
                registerCellNib(named: row, with: tableView)
            }
        }
        hideKeyboard()
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification)
    {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification)
    {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil
        {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    
    @IBAction func chatButtonPressed(_ sender: Any) {
        
         displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
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
}


// ~~~~~~~~~~Extensions~~~~~~~~~~~~~

extension MealLogViewController: CalendarViewControllerDelegate
{
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
}

extension MealLogViewController: UITableViewDataSource, CommentMealDelegate, UITableViewDelegate
{
    
    func commentMealTextViewDidBeginEditing(on row: Int)
    {
        tableView.scrollToRow(at: IndexPath(row: 1, section: row + 3), at: .middle, animated: true)
    }
    
    func saveButtonPressed(with comment: String, on row: Int)
    {
        saveMeal(with: comment, for: row)
    }
    
    func saveMeal(with commment: String, for row: Int)
    {
        updateSaveSectionUI(for: row)
    }
    
    func updateSaveSectionUI(for row: Int)
    {
        isMealSaved[row] = true
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 1, section: row + 3), at: .middle, animated: false)
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var count : Int?
        if tableView == self.tableView
        {
       count = rows.count + meals.count - 3
        }
        else if tableView == self.searchTableView {
            count = 1
        }
        return count!
    }
    
    //~~~~~~Number Of Rows IN A Section~~~~~~~~~~~
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count : Int?
        if tableView == self.tableView
      {
        if section <= 2
          {
            count = 1
          }
        else
           {
            count = 2
           }
        
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
        return count!
    }
   
    // ~~~~~~~~Cell Definition~~~~~~~~~~
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = #imageLiteral(resourceName: "ic_meal_log_24dp")
            cell.lockImageView.image = UIImage()
            cell.titleLabel.textColor = UIColor.black
            cell.titleLabel.text = "MEAL LOG"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealPlan", for: indexPath)
            return cell
        }
        else
        {
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Meals", for: indexPath) as! Meals
                cell.mealPlanBackgroundView.backgroundColor = mealBackgroundColors[indexPath.section - 3]
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
            else
            {
                if isMealSaved[indexPath.section - 3]
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMealCell", for: indexPath)
                    
                    return cell
                }
                else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
                    cell.delegate = self
                    cell.row = indexPath.section - 3
                    return cell
                }
                
            }
        }
    }
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
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.searchTableView {
        cell.backgroundColor = UIColor.clear
        }
    }
}

