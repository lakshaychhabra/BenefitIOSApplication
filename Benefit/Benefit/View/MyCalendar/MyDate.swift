//
//  MyDate.swift
//  Playground
//
//  Created by Delta One on 09/02/18.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation

class MyDate
{
    var dayNumber: Int
    var weekDay: String
    var month: String
    var numberOfDaysInMonth: Int
    var year: Int
    
    init()
    {
        let date = Date()
        let formatter = DateFormatter()
        weekDay = String(formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].first!)
        dayNumber = Calendar.current.component(.day, from: date)
        month = formatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        numberOfDaysInMonth = (Calendar.current.range(of: .day, in: .month, for: date)?.count)!
        year = Calendar.current.component(.year, from: date)
    }
    
    init(from dateNumber: Int, _ monthNumber: Int, _ year: Int)
    {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = monthNumber
        dateComponents.day = dateNumber
        let date = Calendar.current.date(from: dateComponents)!
        let formatter = DateFormatter()
        
        dayNumber = dateNumber
        month = formatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        weekDay = String(formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].first!)
        dayNumber = Calendar.current.component(.day, from: date)
        month = formatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        numberOfDaysInMonth = (Calendar.current.range(of: .day, in: .month, for: date)?.count)!
        self.year = Calendar.current.component(.year, from: date)
    }
    
    func getDayNumber() -> Int
    {
        return dayNumber
    }
    
    func getWeekDay() -> String
    {
        return weekDay
    }
    
    func getMonth() -> String
    {
        return month
    }
    
    func getNumberOfDaysInMonth() -> Int
    {
        return numberOfDaysInMonth
    }
    
    func getYear() -> Int
    {
        return year
    }
    
}
