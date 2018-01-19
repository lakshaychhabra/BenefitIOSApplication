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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar()
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
    
    func setupNavigationBar()
    {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        let label = UILabel()
        label.text = "CHOOSE GOAL"
        label.font = UIFont(name: "Oswald-Medium", size: 25)
        label.textAlignment = .left
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    

   
}
