//
//  File.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 13/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit



class Meals: UIView
{

   
    @IBOutlet var mealView: UIView!
    @IBOutlet var caloriesLabel: UILabel!
    
    @IBOutlet var carbsLabel: UILabel!
    
    @IBOutlet var proteinLabel: UILabel!
    
    @IBOutlet var fatLabel: UILabel!
    
  

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        //        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func commonInit(){
        
        Bundle.main.loadNibNamed("Meals", owner: self, options: nil)
        
        mealView.frame = bounds
        mealView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(mealView)
        
    }

    
}

