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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addTriangularMask()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }

    @IBAction func getStartedButtonPressed(_ sender: SpringButton)
    {
        //performSegue(withIdentifier: "goToChooseGoalScreen", sender: self)
    }
    
    func addTriangularMask()
    {
        let mask = CAShapeLayer()
        mask.frame = self.triangularView.layer.bounds
        let width = self.triangularView.layer.frame.size.width
        let height = self.triangularView.layer.frame.size.height
        print("Top: \(topView.frame.size.width)")
        print("Triangle: \(width)")
        //print(height)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        mask.path = path.cgPath
        //mask.fillColor = UIColor.white.cgColor
        triangularView.layer.mask = mask
    }
}
