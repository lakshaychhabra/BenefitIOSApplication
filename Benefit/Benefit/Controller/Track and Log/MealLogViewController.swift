//
//  WaterIntakeViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MealLogViewController: UIViewController, CalendarViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate,  UISearchBarDelegate, SegueProtocol{
    func coachSegue() {
        //performSegue(withIdentifier: "toCoachTab", sender: self)
        
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
    
//UIPickerViewDelegate
    
    
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
   // @IBOutlet var pickerViewNumber: UIPickerView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var searchTableView: UITableView!
    
    //~~~~~~~~All Attributes IBOUTLETS~~~~~~~~~~
    //breakfast
    @IBOutlet var breakfastCalorieLabel: UILabel!
    @IBOutlet var breakfastCarbsLabel: UILabel!
    @IBOutlet var breakfastFatLabel: UILabel!
    @IBOutlet var breakfastProteinLabel: UILabel!
     //Midbreakdfast
    @IBOutlet var midbreakfastCalorieLabel: UILabel!
    @IBOutlet var midbreakfastCarbsLabel: UILabel!
    @IBOutlet var midbreakfastFatLabel: UILabel!
    @IBOutlet var midbreakfastProteinLabel: UILabel!
    //Lunch
    @IBOutlet var lunchCalorieLabel: UILabel!
    @IBOutlet var lunchCarbsLabel: UILabel!
    @IBOutlet var lunchFatLabel: UILabel!
    @IBOutlet var lunchProteinLabel: UILabel!
    //Snacks
    @IBOutlet var snacksCalorieLabel: UILabel!
    @IBOutlet var snacksCarbsLabel: UILabel!
    @IBOutlet var snacksFatLabel: UILabel!
    @IBOutlet var snacksProteinLabel: UILabel!
    //Dinner
    @IBOutlet var dinnerCalorieLabel: UILabel!
    @IBOutlet var dinnerCarbsLabel: UILabel!
    @IBOutlet var dinnerFatLabel: UILabel!
    @IBOutlet var dinnerProteinLabel: UILabel!
    
    @IBOutlet var tabBarView: TabBar!
    @IBOutlet var chatButton: UIButton!
    
    
    @IBOutlet var butt1: UIButton!
    @IBOutlet var butt3: UIButton!
    @IBOutlet var butt2: UIButton!
    @IBOutlet var butt5: UIButton!
    @IBOutlet var butt4: UIButton!
    // ~~~~~~~All Locally Defined Variables~~~~~~~~~

    var dateSelected : String = ""
    var mealsDish = [""]
    var mealNumber = ["1", "2", "3", "4", "5", "6", "7"]
    let dateFormatter = DateFormatter()
    var completedString = ""
    var filteredData = [String]()
    var isSearching = false
    var breakfast = [String]()
    var midBreakfast = [String]()
    var lunch = [String]()
    var snacks = [String]()
    var dinner = [String]()
    var tag = 0
    var token : String = " "
    var itemNumber : String = "5b239c55c1487836d4076548"
    var calorie : String = "0"
    var carbs : String = "0"
    var protein : String = "0"
    var fats : String = "0"
    let url = "http://13.59.14.56:5000/api/v1/mealLog/details"
//    let tok = ["Authorization" : "yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjViMzIxYzBhOWM0MWZmM2UyMWE5Y2Q5ZiIsIm5hbWUiOiJhYWEiLCJlbWFpbCI6ImFAYS5hIiwiaWF0IjoxNTMxNTU3Mjc5LCJleHAiOjE1MzIxNjIwNzl9.9hAdG6gR0ECw0hBCoWawGdyWiOTBuTpfRLtw3N_vlr4"]
    let tok = ["Authorization" : LoginScreenViewController.token]
    
    func setupButtons(){
       
        butt1.layer.shadowOpacity = 0.5
        butt2.layer.shadowOpacity = 0.5
        butt3.layer.shadowOpacity = 0.5
        butt4.layer.shadowOpacity = 0.5
        butt5.layer.shadowOpacity = 0.5
        
    }
    @IBAction func chatButtonPressed(_ sender: Any) {
        displayAlert(title: "Premium Feature", message: "Chat is a Paid Feature, Be The premium user")
    }
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    func addNavBarImage() {
      
        
        let image = UIImage(named: "benefit_logo") //Your logo url here
        let imageView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
         imageView.image = image

            imageView.contentMode = .scaleAspectFit
            navigationItem.titleView = imageView
            navigationController?.navigationBar.barTintColor = UIColor.init(hex: "f2f2f2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        token = LoginScreenViewController.token
        
        print("Token\(token)")
        
        //TabBar Methods
        tabBarView.delegate = self
        tabBarView.buttonPressed(UIButton.self())
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 2
        chatButton.layer.cornerRadius = chatButton.frame.size.width/2
        chatButton.layer.masksToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        mealsNumberLabel.textAlignment = .center
        popUpView.layer.cornerRadius = 10
        self.searchTableView.backgroundColor = UIColor(hex: "EEEEEE")
        searchBar.returnKeyType = .done
       
          initialTableViews()
        //setupButtons()
        
        let todaysDate = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateSelected = dateFormatter.string(from: todaysDate)
        configuringTableViews()
        print(dateSelected)
        
//        let logo = UIImage(named: "benefit_logo")
//        let imageView = UIImageView(image:logo)
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        self.navigationItem.titleView = imageView
//
        addNavBarImage()
        
        
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.printAccordingToDate(_:)), name: NSNotification.Name(rawValue: "newDate"), object: nil)
        
    }
    
  
    
    
    
    
    func popUpSetup(){
        self.view.addSubview(popUpView)
//        self.popUpView.center.x = self.view.center.x
//        self.popUpView.center.y = self.view.center.y - (self.view.frame.height / 20.0)
    }
    
    
    @IBAction func addMoreButtonClicked(_ sender: UIButton) {
        popUpSetup()
        tag = sender.tag
    }
    
 
    
    //~~~~~~~~~~Picker View Configuration~~~~~~~~~~~~~~~
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return mealNumber.count
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return mealNumber[row]
//
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        mealsNumberLabel.text = mealNumber[row]
//
//    }
    // ~~~~~~~~~~~PickerView ENDS~~~~~~~~~~~~~~
    
    @IBAction func saveFromPopUp(_ sender: UIButton) {
        
      
      
        completedString = mealsDishLabel.text!  //mealsNumberLabel.text! + " \()"
        print(completedString)
        
       
      //  if mealsNumberLabel.text == "" || mealsDishLabel.text == "" {
        if mealsDishLabel.text == "" {
        //do nothing
            print("empty")
        }
            
        else{
            let quantity = Int(mealsNumberLabel.text!)
            let item = mealsDishLabel.text!.components(separatedBy: "+")[1]
            let delimiter = " "
            let carbs1 = mealsDishLabel.text!.components(separatedBy: "carbs: ")[1]
            let fats1 = mealsDishLabel.text!.components(separatedBy: "fats: ")[1]
            let protein1 = mealsDishLabel.text!.components(separatedBy: "protein: ")[1]
            let finalString = mealsDishLabel.text!.components(separatedBy: "+")[0]
            calorie = mealsDishLabel.text!.components(separatedBy: "calories: ")[1]
            carbs = carbs1.components(separatedBy: delimiter)[0]
            fats = fats1.components(separatedBy: delimiter)[0]
            protein = protein1.components(separatedBy: delimiter)[0]
            itemNumber = item.components(separatedBy: delimiter)[0]
            let final = finalString.capitalized
            
            if tag == 0{
                breakfast.append(final)
                print(breakfast)
                settingUpDataBreakfast(calories: calorie, carbs: carbs, proteins: protein, fats: fats)
                breakfastTableView.reloadData()
                let parameters : [String : AnyObject] = ["type" : "Breakfast" as AnyObject, "date" : dateSelected as AnyObject, "food" : [["item" : itemNumber],["quantity" : quantity ?? 1]] as AnyObject]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: tok).responseJSON { response  in
                    
                        print(response)
                 
                }
                
                
                 print("\(carbs, fats, protein)")
                print(parameters)
            }
            if tag == 1{
                
                midBreakfast.append(final)
                print(midBreakfast)
                settingUpDataMidbreakfast(calories: calorie, carbs: carbs, proteins: protein, fats: fats)
                midbreakfastTableView.reloadData()
                
                let parameters : [String : AnyObject] = ["type" : "MidBreakfast" as AnyObject, "date" : dateSelected as AnyObject, "food" : [["item" : itemNumber],["quantity" : quantity ?? 1]] as AnyObject]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: tok).responseJSON { response  in
                    
                    print(response)
                    
                }
                
                print("\(carbs, fats, protein)")
                print(parameters)
                
            }
            if tag == 2{
                lunch.append(final)
                settingUpDataLunch(calories: calorie, carbs: carbs, proteins: protein, fats: fats)
                lunchTableView.reloadData()
                
                let parameters : [String : AnyObject] = ["type" : "Lunch" as AnyObject, "date" : dateSelected as AnyObject, "food" : [["item" : itemNumber],["quantity" : quantity ?? 1]] as AnyObject]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: tok).responseJSON { response  in
                    
                    print(response)
                    
                }
                
                print("\(carbs, fats, protein)")
                print(parameters)
            }
            if tag == 3{
                snacks.append(final)
                settingUpDataSnacks(calories: calorie, carbs: carbs, proteins: protein, fats: fats)
                snacksTableView.reloadData()
                
                let parameters : [String : AnyObject] = ["type" : "Snacks" as AnyObject, "date" : dateSelected as AnyObject, "food" : [["item" : itemNumber],["quantity" : quantity ?? 1]] as AnyObject]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: tok).responseJSON { response  in
                    
                    print(response)
                    
                }
                
                print("\(carbs, fats, protein)")
                print(parameters)
                
            }
            if tag == 4{
                dinner.append(final)
                settingUpDataDinner(calories: calorie, carbs: carbs, proteins: protein, fats: fats)
                dinnerTableView.reloadData()
                let parameters : [String : AnyObject] = ["type" : "Dinner" as AnyObject, "date" : dateSelected as AnyObject, "food" : [["item" : itemNumber],["quantity" : quantity ?? 1]] as AnyObject]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: tok).responseJSON { response  in
                    print(response)
                }
                
                print("\(carbs, fats, protein)")
                print(parameters)
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
            
           
            

            let url1 = "http://13.59.14.56:5000/api/v1/mealLog/food/search/\(searchText.uppercased())"
            let url2 = url1.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let tok = ["Authorization" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjViMzIxYzBhOWM0MWZmM2UyMWE5Y2Q5ZiIsIm5hbWUiOiJhYWEiLCJlbWFpbCI6ImFAYS5hIiwiaWF0IjoxNTMwMDMzNjk3LCJleHAiOjE1MzA2Mzg0OTd9.jpUeZRjlHAFIYFY_LcsTkjG7rxPZHCgoR4uNNpWpD-g"]
            
            
            Alamofire.request(url2!, method: .get, headers: tok).responseJSON { response in
               
                print(response)
                
                if let response = response.result.value {
                    let data : JSON = JSON(response)
                    print(data)
                    print(data["data"].count)
                    var dat : String
                   
                    var i = 0
                        while i < data["data"].count {
                            
                            dat = "\(data["data"][i]["name"].rawString() ?? " ")                                                                                                                          +\(data["data"][i]["_id"].rawString() ?? " ") carbs: \(data["data"][i]["carbs"].rawString() ?? " ") fats: \(data["data"][i]["fats"].rawString() ?? " ") protein: \(data["data"][i]["proteins"].rawString() ?? " ") calories: \(data["data"][i]["calories"].rawString() ?? " ")"
                        print(dat)
                            if dat == ""{
                                print("No Data")
                                
                            }
                            else {
                                
                                self.filteredData.append(dat)
                            }
                             self.searchTableView.reloadData()
                              i += 1
                          
                    }
                }
                
            }

        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    var monthNumber : String = "00"
    // ~~~~~~~ Setting Up Calendar ~~~~~~~~~
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
        
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        let indexPath = IndexPath(row: 0, section: 1)
        if tableView.rectForRow(at: indexPath).contains(touch.location(in: tableView.cellForRow(at: indexPath)))
        {
            print("False")
            return false
        }
        print("true")
        return true
    }
    
    //~~~~~~~~~Setting up calories~~~~~~~~~
    func settingUpDataBreakfast(calories : String, carbs : String, proteins : String, fats : String){
      
        breakfastCalorieLabel.text = String(Int(breakfastCalorieLabel.text!)! + Int(calories)!)
        breakfastFatLabel.text = String(Int(breakfastFatLabel.text!)! + Int(fats)!)
        breakfastCarbsLabel.text = String(Int(breakfastFatLabel.text!)! + Int(carbs)!)
        breakfastProteinLabel.text = String(Int(breakfastProteinLabel.text!)! + Int(proteins)!)
       
    }
    func settingUpDataMidbreakfast(calories : String, carbs : String, proteins : String, fats : String){
        
        midbreakfastCalorieLabel.text = String(Int(midbreakfastCalorieLabel.text!)! + Int(calories)!)
        midbreakfastFatLabel.text = String(Int(midbreakfastFatLabel.text!)! + Int(fats)!)
        midbreakfastCarbsLabel.text = String(Int(midbreakfastFatLabel.text!)! + Int(carbs)!)
        midbreakfastProteinLabel.text = String(Int(midbreakfastProteinLabel.text!)! + Int(proteins)!)
        
    }
    func settingUpDataLunch(calories : String, carbs : String, proteins : String, fats : String){
        
         lunchCalorieLabel.text = String(Int(lunchCalorieLabel.text!)! + Int(calories)!)
        lunchFatLabel.text = String(Int(lunchFatLabel.text!)! + Int(fats)!)
        lunchCarbsLabel.text = String(Int(lunchFatLabel.text!)! + Int(carbs)!)
        lunchProteinLabel.text = String(Int(lunchProteinLabel.text!)! + Int(proteins)!)
        
    }
    func settingUpDataSnacks(calories : String, carbs : String, proteins : String, fats : String){
        
        snacksCalorieLabel.text = String(Int(snacksCalorieLabel.text!)! + Int(calories)!)
        snacksFatLabel.text = String(Int(snacksFatLabel.text!)! + Int(fats)!)
        snacksCarbsLabel.text = String(Int(snacksCarbsLabel.text!)! + Int(carbs)!)
        snacksProteinLabel.text = String(Int(snacksProteinLabel.text!)! + Int(proteins)!)
        
        
    }
    func settingUpDataDinner(calories : String, carbs : String, proteins : String, fats : String){
        
        dinnerCalorieLabel.text = String(Int(dinnerCalorieLabel.text!)! + Int(calories)!)
        dinnerFatLabel.text = String(Int(dinnerFatLabel.text!)! + Int(fats)!)
        dinnerCarbsLabel.text = String(Int(dinnerCarbsLabel.text!)! + Int(carbs)!)
        dinnerProteinLabel.text = String(Int(dinnerProteinLabel.text!)! + Int(proteins)!)
        
    }
    
    
    
    func initialTableViews(){
        
        //Setting up initial looks
        if breakfast.count == 0 {
            breakfastCalorieLabel.text = "0"
            breakfastFatLabel.text = "0"
            breakfastCarbsLabel.text = "0"
            breakfastProteinLabel.text = "0"
            
        }
        if midBreakfast.count == 0 {
            midbreakfastCalorieLabel.text = "0"
            midbreakfastFatLabel.text = "0"
            midbreakfastCarbsLabel.text = "0"
            midbreakfastProteinLabel.text = "0"
        }
        if lunch.count == 0 {
            
            lunchCalorieLabel.text = "0"
            lunchFatLabel.text = "0"
            lunchCarbsLabel.text = "0"
            lunchProteinLabel.text = "0"
            
        }
        if snacks.count == 0 {
            snacksCalorieLabel.text = "0"
            snacksFatLabel.text = "0"
            snacksCarbsLabel.text = "0"
            snacksProteinLabel.text = "0"
            
        }
        if dinner.count == 0 {
            dinnerCalorieLabel.text = "0"
            dinnerFatLabel.text = "0"
            dinnerCarbsLabel.text = "0"
            dinnerProteinLabel.text = "0"
            
        }
    }
    
    // ~~~~~~~~~ Setting Up Table View ~~~~~~~~~
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
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
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
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
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
            return cell!
            
        
        }
       else if midBreakfast.count != 0 && tableView == self.midbreakfastTableView{
            
            let cell = midbreakfastTableView.dequeueReusableCell(withIdentifier: "midbreakfastCell")
            cell?.textLabel?.text = midBreakfast[indexPath.row]
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
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
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
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
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
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
            cell?.textLabel?.textColor = UIColor.init(hex: "222222")
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
            
           // print(mealsDish[indexPath.row])
            if isSearching {
                mealsDishLabel.text = filteredData[indexPath.row]
            }
            else {
                
                mealsDishLabel.text = ""
            }
            
        }
    }
    
    // ~~~~~~~~~~ Appearance of Search Table View ~~~~~~~~~~
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.searchTableView {
            cell.backgroundColor = UIColor.clear
        }
    }

    //Mark: -  ~~~~~Configuring Tableview At Selected Date~~~~~~~~~~~
    @objc func printAccordingToDate(_ notification: NSNotification){
        
             configuringTableViews()
        
      }

    func configuringTableViews(){
        let urlB = "http://13.59.14.56:5000/api/v1/mealLog/details/?type=Breakfast&date=\(dateSelected)"
        print(urlB)
        let urlM = "http://13.59.14.56:5000/api/v1/mealLog/details/?type=MidBreakfast&date=\(dateSelected)"
        let urlL = "http://13.59.14.56:5000/api/v1/mealLog/details/?type=Lunch&date=\(dateSelected)"
        let urlS = "http://13.59.14.56:5000/api/v1/mealLog/details/?type=Snacks&date=\(dateSelected)"
        let urlD = "http://13.59.14.56:5000/api/v1/mealLog/details/?type=Dinner&date=\(dateSelected)"
        
        Alamofire.request(urlB, method: .get, headers: tok).responseJSON { response in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                print(data["success"])
                if data["success"].rawString() == "false"{
                    print("No data")
                    self.breakfast.removeAll()
                    self.breakfastTableView.reloadData()
                }
                else {
                    let food = data["data"]["food"]
                    print(food.count)
                    var i = 0
                    var foodValue : String! = " "
                    
                    while i<food.count{
                        foodValue = food[i]["item"]["name"].rawString()!
                        print(foodValue)
                        
                        if foodValue == nil {
                            print("Nothing for that day")
                            self.breakfast.removeAll()
                            self.breakfastTableView.reloadData()
                        }
                        else{
                            self.breakfast.append(foodValue)
                            self.breakfastTableView.reloadData()
                        }
                        i += 1
                    }
                }
            }
        }
        //Response for MidBreakFast
        
        Alamofire.request(urlM, method: .get, headers: tok).responseJSON { response in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                print(data["success"])
                if data["success"].rawString() == "false"{
                    print("No data")
                    self.midBreakfast.removeAll()
                    self.midbreakfastTableView.reloadData()
                }
                else {
                    let food = data["data"]["food"]
                    print(food.count)
                    var i = 0
                    var foodValue : String! = " "
                    
                    while i<food.count{
                        foodValue = food[i]["item"]["name"].rawString()!
                        print(foodValue)
                        
                        if foodValue == nil {
                            print("Nothing for that day")
                            self.midBreakfast.removeAll()
                            self.midbreakfastTableView.reloadData()
                        }
                        else{
                            self.midBreakfast.append(foodValue)
                            self.midbreakfastTableView.reloadData()
                        }
                        i += 1
                    }
                }
            }
        }
        
        //~~~~~~~~~Lunch~~~~~~~~`
        Alamofire.request(urlL, method: .get, headers: tok).responseJSON { response in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                print(data["success"])
                if data["success"].rawString() == "false"{
                    print("No data")
                    self.lunch.removeAll()
                    self.lunchTableView.reloadData()
                }
                else {
                    let food = data["data"]["food"]
                    print(food.count)
                    var i = 0
                    var foodValue : String! = " "
                    
                    while i<food.count{
                        foodValue = food[i]["item"]["name"].rawString()!
                        print(foodValue)
                        
                        if foodValue == nil {
                            print("Nothing for that day")
                            self.lunch.removeAll()
                            self.lunchTableView.reloadData()
                        }
                        else{
                            self.lunch.append(foodValue)
                            self.lunchTableView.reloadData()
                        }
                        i += 1
                    }
                }
            }
        }
        
        //~~~~~~~~~Snacks~~~~~~~~~~~
        Alamofire.request(urlS, method: .get, headers: tok).responseJSON { response in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                print(data["success"])
                if data["success"].rawString() == "false"{
                    print("No data")
                    self.snacks.removeAll()
                    self.snacksTableView.reloadData()
                }
                else {
                    let food = data["data"]["food"]
                    print(food.count)
                    var i = 0
                    var foodValue : String! = " "
                    
                    while i<food.count{
                        foodValue = food[i]["item"]["name"].rawString()!
                        print(foodValue)
                        
                        if foodValue == nil {
                            print("Nothing for that day")
                            self.snacks.removeAll()
                            self.snacksTableView.reloadData()
                        }
                        else{
                            self.snacks.append(foodValue)
                            self.snacksTableView.reloadData()
                        }
                        i += 1
                    }
                }
            }
        }
        //~~~~~~~~~Dinner~~~~~~~~~~~
        Alamofire.request(urlD, method: .get, headers: tok).responseJSON { response in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                print(data["success"])
                if data["success"].rawString() == "false"{
                    print("No data")
                    self.dinner.removeAll()
                    self.dinnerTableView.reloadData()
                }
                else {
                    let food = data["data"]["food"]
                    print(food.count)
                    var i = 0
                    var foodValue : String! = " "
                    
                    while i<food.count{
                        foodValue = food[i]["item"]["name"].rawString()!
                        print(foodValue)
                        
                        if foodValue == nil {
                            print("Nothing for that day")
                            self.dinner.removeAll()
                            self.dinnerTableView.reloadData()
                        }
                        else{
                            self.dinner.append(foodValue)
                            self.dinnerTableView.reloadData()
                        }
                        i += 1
                    }
                }
            }
        }
        
     
    }

}
