//
//  HomeScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 21/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController
{

    @IBOutlet weak var chatButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupRounded(button: chatButton)

    }
    
    func setupNavigationBarItems()
    {
        navigationController?.navigationBar.isHidden = true
        
        let customNavigationBar = UIView()
        customNavigationBar.frame = navigationController!.navigationBar.frame
        view.addSubview(customNavigationBar)
        
        let colorView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        colorView.backgroundColor = UIColor.red
        customNavigationBar.addSubview(colorView)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: colorView, attribute: .top, relatedBy: .equal, toItem: customNavigationBar, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        
        
    }
    
    @IBAction func workoutsButtonPressed(_ sender: UIButton)
    {
        print("Workout")
    }
    
    @IBAction func nutritionButtonPressed(_ sender: UIButton)
    {
        print("Nutrition")
    }
    
    @IBAction func trackAndLogButtonPressed(_ sender: UIButton)
    {
        print("Track and Log")
    }
    
    
    @IBAction func measurementButtonPressed(_ sender: UIButton)
    {
        print("Measurement")
    }
    
    
    @IBAction func challengesButtonPressed(_ sender: UIButton)
    {
        print("Challenges")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
