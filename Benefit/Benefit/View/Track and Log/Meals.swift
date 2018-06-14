//
//  File.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class Meals: UITableViewCell, UITextViewDelegate
{

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
    
    @IBAction func addMoreButtonPressed(_ sender: Any) {
        
        if state == 0 {
            label1.text = "4 egssssss  sssss"
            state += 1
        }
        else if state == 1 {
            label2.text = "4 egssssss  sssss"
            state += 1
        }
        else if state == 2 {
            label3.text = "4 egssssss  sssss"
            state += 1
        }
        else if state == 3 {
            label4.text = "4 egssssss  sssss"
            state += 1
        }
        else {
            print("Limit exceeded")
        }
        
    }
    
}

