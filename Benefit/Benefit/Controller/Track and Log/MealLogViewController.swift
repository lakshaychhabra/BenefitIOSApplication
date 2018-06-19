//
//  MealLogViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class MealLogViewController: UIViewController, SegueProtocol, UIPickerViewDelegate, UIPickerViewDataSource, MealView{
    func callingTheView() {
        self.view.addSubview(popUpView)
        self.popUpView.center.x = self.view.center.x
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 10.0)
        
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
    
    @IBOutlet var popUpView: UIView!
    
    
    @IBAction func saveFromPopUp(_ sender: UIButton) {
        
        self.popUpView.removeFromSuperview()
        completedString =  mealNumberTextField.text! + " \(mealsDishTextField.text!)"
        print(completedString)
        
        let abcd : [String : String] = ["value" : completedString]
        if mealNumberTextField.text == "" && mealsDishTextField.text == "" {
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
    }
    var completedString = ""
    @IBOutlet var mealNumberTextField: UITextField!
    @IBOutlet var pickerViewDish: UIPickerView!
    @IBOutlet var mealsDishTextField: UITextField!
    
    @IBOutlet var pickerViewNumber: UIPickerView!
    var mealsDish = ["eggs", "Juice", "Rotis", "Bananas", "A Glass of Juice"]
    var mealNumber = ["1", "2", "3", "4", "5", "6", "7"]
    
    var state = 0
    let rows = ["PremiumFeatureCell", "CalendarCell", "TodaysNutritionPlan", "Meals", "CommentCell", "SavedMealCell"]
    let mealBackgroundColors = [UIColor(hex: "E0A662"), UIColor(hex: "73C997"), UIColor(hex: "457B97"), UIColor(hex: "C64A4D"), UIColor(hex: "2A373E")]
    let meals = ["Breakfast", "Mid-morning", "Lunch", "Snacks", "Dinner"]
    var isMealSaved = [false, false, false, false, false]
    
    @IBOutlet var chatButton: UIButton!
    var currentSection = 0
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabBar: TabBar!
    
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
        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 8.0)
        
        mealsDishTextField.inputView = pickerViewDish
        mealsDishTextField.textAlignment = .center
        mealsDishTextField.placeholder = "Select one please"
        
        mealNumberTextField.inputView = pickerViewNumber
        mealNumberTextField.textAlignment = .center
        mealNumberTextField.placeholder = "Num"
        
        popUpView.layer.cornerRadius = 10
        
    }

  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
  
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
          return mealsDish.count
        } else{
            return mealNumber.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return mealsDish[row]
        } else{
            return mealNumber[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            mealsDishTextField.text = mealsDish[row]
             mealsDishTextField.resignFirstResponder()
        } else{
           
            mealNumberTextField.text = mealNumber[row]
            mealNumberTextField.resignFirstResponder()
        }
     
    }
    
   
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
}
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
        return rows.count + meals.count - 3
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
}

