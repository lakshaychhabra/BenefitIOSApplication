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
        let benefitImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        benefitImageView.contentMode = .scaleAspectFit
        benefitImageView.image = #imageLiteral(resourceName: "benefit_logo")
//        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: benefitImageView)
//
//        navigationController?.view.addSubview(benefitImageView)
        navigationItem.titleView = benefitImageView
        
        let notificationsButton = UIButton(type: .system)
        notificationsButton.setImage(#imageLiteral(resourceName: "ic_notif_24dp"), for: .normal)
        notificationsButton.imageView?.contentMode = .scaleAspectFit
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationsButton)
        
        let coachButton = UIButton(type: .system)
        coachButton.setImage(#imageLiteral(resourceName: "ic_coach_24dp"), for: .normal)
        coachButton.imageView?.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: coachButton))
        
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
