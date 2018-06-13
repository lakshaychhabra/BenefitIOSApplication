//
//  NutritionDiet.swift
//  Benefit
//
//  Created by Delta One on 15/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class NutritionDiet: UITableViewCell, UITextViewDelegate
{
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPlanBackgroundView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
