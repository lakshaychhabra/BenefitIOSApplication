//
//  HomeScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 19/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Spring

class StartupScreenViewController: UIViewController
{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var runnerImage: UIImageView!
    @IBOutlet weak var triangularView: UIView!
    @IBOutlet weak var topHalfView: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }
    
   

    @IBAction func getStartedButtonPressed(_ sender: SpringButton)
    {
        //performSegue(withIdentifier: "goToChooseGoalScreen", sender: self)
    }
}
