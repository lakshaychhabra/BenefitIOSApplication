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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //addTriangularMaskToTopView()
        //runAnimation()
        //self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        //self.navigationController?.isNavigationBarHidden = false
    }
    

    @IBAction func getStartedButtonPressed(_ sender: SpringButton)
    {
        //performSegue(withIdentifier: "goToChooseGoalScreen", sender: self)
    }
    
//    func addTriangularMaskToTopView()
//    {
//        let origin = layerView.frame.origin
//        let width = layerView.frame.size.width
//        let height = layerView.frame.size.height
//
//        let point1 = CGPoint(x: origin.x, y: origin.y + height)
//        let point2 = CGPoint(x: origin.x + width, y: origin.y)
//        let point3 = CGPoint(x: origin.x + width, y: origin.y + height)
//
//        let path = UIBezierPath()
//        path.move(to: point1)
//        path.addLine(to: point2)
//        path.addLine(to: point3)
//        path.close()
//
//        let mask = CAShapeLayer()
//        mask.frame = layerView.bounds
//        mask.fillColor = UIColor.black.cgColor
//        mask.path = path.cgPath
//
//        layerView.layer.mask = mask
//
//    }

    
}
