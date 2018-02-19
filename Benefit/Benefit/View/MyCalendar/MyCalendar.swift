//
//  Calendar.swift
//  Playground
//
//  Created by Delta One on 15/02/18.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

protocol CalendarViewControllerDelegate
{
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
}

class MyCalendar: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
    var delegateForHandlingDates: CalendarViewControllerDelegate?
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var selectedDateIndexPath: IndexPath!
    var selectedMonthIndexPath: IndexPath!
    
    var currentYear: Int!
    var currentMonth: String!
    var currentDayNumber: Int!
    var currentWeekDay: String!
    var numberOfDaysInMonth: Int!
    
    var selectedDayNumber: Int!
    var selectedMonth: String!
    var monthCorrespondingToSelectedDate: String!
    
    let today = MyDate()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupCalendar()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupCalendar()
    }
    
    func setupCalendar()
    {
        loadNib(named: "MyCalendar")
        registerCollectionCell(named: "MonthCell", with: monthCollectionView)
        registerCollectionCell(named: "DayCell", with: dayCollectionView)
        initCurrentDateVariables()
        scrollToCurrentDates()
    }
    
    func loadNib(named nibName: String)
    {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func registerCollectionCell(named cellName: String, with collectionView: UICollectionView)
    {
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initCurrentDateVariables()
    {
        currentYear = today.getYear()
        currentDayNumber = today.getDayNumber()
        currentMonth = today.getMonth()
        currentWeekDay = today.getWeekDay()
        numberOfDaysInMonth = today.getNumberOfDaysInMonth()
        
        selectedDayNumber = currentDayNumber
        selectedMonth = currentMonth
        monthCorrespondingToSelectedDate = selectedMonth
        selectedDateIndexPath = IndexPath(item: currentDayNumber - 1, section: 0)
        selectedMonthIndexPath = IndexPath(item: months.index(of: currentMonth)!, section: 0)
        //print(selectedDateIndexPath)
    }
    
    func scrollToCurrentDates()
    {
        contentView.layoutIfNeeded()
        dayCollectionView.scrollToItem(at: selectedDateIndexPath, at: .centeredHorizontally, animated: false)
        monthCollectionView.scrollToItem(at: selectedMonthIndexPath, at: .centeredHorizontally, animated: false)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == monthCollectionView
        {
            return 12
        }
        else
        {
            return numberOfDaysInMonth
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == monthCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath) as! MonthCell
            currentMonth = months[indexPath.row]
            cell.monthLabel.text = currentMonth.uppercased()
            
            if currentMonth == selectedMonth
            {
                cell.monthLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
            }
            else
            {
                cell.monthLabel.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1.0)
            }
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
            currentDayNumber = indexPath.row + 1
            currentWeekDay = getWeekDay(from: currentDayNumber, months.index(of: selectedMonth)! + 1, currentYear)
            cell.dateLabel.text = String(currentDayNumber)
            cell.dayLabel.text = currentWeekDay
            cell.layer.cornerRadius = 20
            
            if cell.dateLabel.text! == String(selectedDayNumber) && selectedMonth == monthCorrespondingToSelectedDate
            {
                cell.viewWithTag(13)?.backgroundColor = UIColor(red: 245/255, green: 225/255, blue: 114/255, alpha: 1.0)
            }
            else
            {
                cell.viewWithTag(13)?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
            }
            
            return cell
        }
    }
    
    func getWeekDay(from dateNumber: Int, _ monthNumber: Int, _ year: Int) -> String
    {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = monthNumber
        dateComponents.day = dateNumber
        let date = Calendar.current.date(from: dateComponents)!
        let formatter = DateFormatter()
        return String(formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].first!)
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("IamSelected")
        if collectionView == monthCollectionView
        {
            if let cell = collectionView.cellForItem(at: selectedMonthIndexPath) as? MonthCell
            {
                cell.monthLabel.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1.0)
            }
            let cell = collectionView.cellForItem(at: indexPath) as! MonthCell
            cell.monthLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
            selectedMonthIndexPath = indexPath
            selectedMonth = cell.monthLabel.text!.capitalized
            
            //set number of days in selected month
            let dateComponents = DateComponents(year: currentYear, month: months.index(of: selectedMonth)! + 1)
            let date = Calendar.current.date(from: dateComponents)!
            
            numberOfDaysInMonth = Calendar.current.range(of: .day, in: .month, for: date)!.count
            dayCollectionView.reloadData()
            
        }
        else
        {
            if let cell = collectionView.cellForItem(at: selectedDateIndexPath) as? DayCell
            {
                cell.viewWithTag(13)?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
            }
            let cell = collectionView.cellForItem(at: indexPath) as! DayCell
            cell.viewWithTag(13)?.backgroundColor = UIColor(red: 245/255, green: 225/255, blue: 114/255, alpha: 1.0)
            selectedDateIndexPath = indexPath
            selectedDayNumber = Int(cell.dateLabel.text!)!
            monthCorrespondingToSelectedDate = selectedMonth
            delegateForHandlingDates?.respondToChangeInSelectedDate(for: selectedDayNumber, monthCorrespondingToSelectedDate, currentYear)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenRect: CGRect = UIScreen.main.bounds
        let screenWidth: CGFloat = screenRect.size.width
        if collectionView == monthCollectionView
        {
            let cellWidth = Float((screenWidth / 3.0))
            let cellHeight = collectionView.frame.size.height
            let size = CGSize(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
            return size
        }
        else
        {
            let cellWidth = Float((screenWidth / 7.0))
            let cellHeight = collectionView.frame.size.height
            let size = CGSize(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
            return size
        }
    }
}

