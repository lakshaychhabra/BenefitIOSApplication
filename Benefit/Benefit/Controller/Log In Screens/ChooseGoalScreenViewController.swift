//
//  ChooseGoalScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 19/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import ImageSlideshow

class ChooseGoalScreenViewController: UIViewController
{

    @IBOutlet weak var imageSlider: ImageSlideshow!
    let imageSource = [ImageSource(image: #imageLiteral(resourceName: "burn_fat")), ImageSource(image: #imageLiteral(resourceName: "stay_healthy")), ImageSource(image: #imageLiteral(resourceName: "build_muscle"))]
    var goals = ["burn fat", "stay healthy", "build muscle"]
    var selectedGoal = "burn fat"
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar(with: "CHOOSE GOAL")
        setupImageSlider()

    }

    func setupImageSlider()
    {
        imageSlider.setImageInputs(imageSource)
        imageSlider.circular = false
        imageSlider.pageControlPosition = PageControlPosition.underScrollView
        imageSlider.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        imageSlider.pageControl.pageIndicatorTintColor = UIColor.black
    }
    
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        let check = UserDefaults.standard.bool(forKey: "UserAlreadyLoggedIn")
        print(check)
        if check == true {
            
            
            
            self.performSegue(withIdentifier: "afterLogInFromStartUp", sender: self)
        
        }else{
        selectedGoal = goals[imageSlider.currentPage]
        print(selectedGoal)
            self.performSegue(withIdentifier: "setUpProfile", sender: self)
        }
    }
    
   
}
