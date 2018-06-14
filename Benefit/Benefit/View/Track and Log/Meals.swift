//
//  File.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

protocol MealView {
    func callingTheView()
   // func gettingTheValue() -> String
}


class Meals: UITableViewCell, UITextViewDelegate
{

    var stringValue : String? = " "
    var delegate: MealView?
    var state = 0
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPlanBackgroundView: UIView!
    
    @IBOutlet var label1: UILabel!
    
    @IBOutlet var label4: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var addMore: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
   
    var meal : MealLogViewController = MealLogViewController()
    @IBAction func addMoreButtonPressed(_ sender: UIButton) {
        
   
    delegate?.callingTheView()
        
        //stringValue = delegate?.gettingTheValue()
        stringValue = meal.finalValue()
        
        if state == 0 {
            label1.text = stringValue
            state += 1
        }
        else if state == 1 {
            label2.text = stringValue
            state += 1
        }
        else if state == 2 {
            label3.text = stringValue
            state += 1
        }
        else if state == 3 {
            label4.text = stringValue
            state += 1
        }
        else {
            print("Limit exceeded")
        }
        
    }
    
}

