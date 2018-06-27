//
//  Food.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 26/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import Foundation


struct Food {
    
    var name: String!
    var carbs: Int!
    var calories: Int!
    var protein: Int!
    var fat: Int!
    
    init(name: String, calories: Int, carbs: Int, protein: Int, fat: Int) {
        self.name = name
        self.calories = calories
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
    }
    
}

