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

    
    var delegate: MealView?
    var state = 0
    
    var meal : MealLogViewController = MealLogViewController()
    var stringValue : String? = " "
   
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
       // stringValue = meal.finalValue()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshLabel1(_:)), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshLabel2(_:)), name: NSNotification.Name(rawValue: "refresh2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshLabel3(_:)), name: NSNotification.Name(rawValue: "refresh3"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshLabel4(_:)), name: NSNotification.Name(rawValue: "refresh4"), object: nil)
        
    }
    @objc func refreshLabel1(_ notification: NSNotification) {
        
        print("Received Notification")
        label1.text = notification.userInfo?["value"] as? String
    }
    @objc func refreshLabel2(_ notification: NSNotification) {
        
        print("Received Notification")
        label2.text = notification.userInfo?["value"] as? String
    }
    @objc func refreshLabel3(_ notification: NSNotification) {
        
        print("Received Notification")
        label3.text = notification.userInfo?["value"] as? String
    }
    @objc func refreshLabel4(_ notification: NSNotification) {
        
        print("Received Notification")
        label4.text = notification.userInfo?["value"] as? String
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    

    
    @IBAction func addMoreButtonPressed(_ sender: UIButton) {
        
   
    delegate?.callingTheView()
        
        //stringValue = delegate?.gettingTheValue()
        
    }
    
}

