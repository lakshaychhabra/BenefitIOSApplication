//
//  BMIScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 20/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class BMIScreenViewController: UIViewController
{
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var healthStatusLabel: UILabel!
    @IBOutlet weak var expertCoachOptionButton: UIButton!
    @IBOutlet weak var selfOptionButton: UIButton!
    var height: Double!
    var weight: Double!
    var heightUnit: String!
    var weightUnit: String!
    var category = ""
    var delegate: SetupProfileScreenViewController?
    var messages =
    [
        "OBESE": "Shed down some weight, limit your calorie intake, exercise regularly and improve your metabolism",
        "NORMAL": "Make healthy food choices and participate in regular physical activities to be more fit and in shape",
        "OVERWEIGHT": "Increase physical activity and improve your diet",
        "UNDERWEIGHT": "Eat nutrient rich food and strengthen your muscles"
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let bmi = String(format: "%.2f", calculateBMI())
        updateUI(with: bmi)
        expertCoachOptionButton.titleLabel?.textAlignment = .center
        selfOptionButton.titleLabel?.textAlignment = .center
        
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
//        let gradient = createGradient(from: horizontalSeparator.frame)
//        self.horizontalSeparator.layer.insertSublayer(gradient, at: 0)
    }
    
    func calculateBMI() -> Double
    {
        let height = convertIntoMetre(self.height)
        let weight = convertIntoKG(self.weight)
        let BMI = weight / (height * height)
        
        if BMI >= 30.0
        {
            category = "OBESE"
        }
        else if BMI >= 25.0 && BMI <= 29.9
        {
            category = "OVERWEIGHT"
        }
        else if BMI >= 18.5 && BMI <= 24.9
        {
            category = "NORMAL"
        }
        else if BMI < 18.5
        {
            category = "UNDERWEIGHT"
        }
        
        return BMI
    }
    
    func convertIntoMetre(_ length: Double) -> Double
    {
        switch heightUnit
        {
        case "in":
            return length * 0.0254
        case "ft":
            return length * 0.3048
        default:
            return length * 0.01
        }
    }
    
    func convertIntoKG(_ weight: Double) -> Double
    {
        switch weightUnit
        {
        case "lbs":
            return 0.45 * weight
        default:
            return weight
        }
    }
    
    func updateUI(with bmi: String)
    {
        bmiLabel.text = bmi
        healthStatusLabel.text = category
        messageLabel.text = messages[category]
        switch category
        {
        case "NORMAL":
            healthStatusLabel.textColor = UIColor(hex: "#bfea58")
        case "OVERWEIGHT":
            healthStatusLabel.textColor = UIColor(hex: "#ff6e40")
        case "UNDERWEIGHT":
            healthStatusLabel.textColor = UIColor(hex: "#ffd54f")
        case "OBESE":
            healthStatusLabel.textColor = UIColor(hex: "#ff1744")
        default:
            return
        }
    }
//    
//    func createGradient(from bounds: CGRect) -> CAGradientLayer
//    {
//        let topColor = UIColor(hex: "#fe0a02").cgColor
//        let bottomColor = UIColor(hex: "#f27701").cgColor
//        let gradientColors = [topColor, bottomColor]
//        
//        let gradientLocations: [NSNumber] = [0.0, 0.5]
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = gradientColors
//        gradientLayer.locations = gradientLocations
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradientLayer.frame = bounds
//        return gradientLayer
//    }
    
   
}
