//
//  TabBar.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 01/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

protocol SegueProtocol : class {
    // protocol definition goes here
    func coachSegue()
    func notificationSegue()
    func menuSegue()
    func homeSegue()
}



 class TabBar: UIView {

    
     weak var delegate:SegueProtocol?


    
    
    @IBOutlet var tabBarView: UIView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var coachButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    

        let homeImage = UIImage(named: "ic_home_sel") as UIImage?
        let homeDefault = UIImage(named: "ic_home") as UIImage?
        let notifImage = UIImage(named: "ic_notif_sel") as UIImage?
        let notifDefault = UIImage(named: "ic_notif") as UIImage?
        let coachImage = UIImage(named: "ic_coach_sel") as UIImage?
        let coachDefault = UIImage(named: "ic_coach") as UIImage?
        let menuImage = UIImage(named: "ic_menu_sel") as UIImage?
        let menuDefault = UIImage(named: "ic_menu") as UIImage?
    
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

        Bundle.main.loadNibNamed("TabBar", owner: self, options: nil)

        tabBarView.frame = bounds
        tabBarView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(tabBarView)

    }


    
    
     func homeButtonPressed() {
        homeButton.setImage(homeImage, for: [])
        notificationButton.setImage(notifDefault, for: [])
        coachButton.setImage(coachDefault, for: [])
        menuButton.setImage(menuDefault, for: [])
        
    }
    
    
     func notificationButtonPressed() {
        
        
        
        homeButton.setImage(homeDefault, for: [])
        notificationButton.setImage(notifImage, for: [])
        coachButton.setImage(coachDefault, for: [])
        menuButton.setImage(menuDefault, for: [])
        
        
    }
    
    
     func coachButtonPressed() {
        
        homeButton.setImage(homeDefault, for: [])
        notificationButton.setImage(notifDefault, for: [])
        coachButton.setImage(coachImage, for: [])
        menuButton.setImage(menuDefault, for: [])
        
        
    }
    
   
     func menuButtonPressed() {
        
        homeButton.setImage(homeDefault, for: [])
        notificationButton.setImage(notifDefault, for: [])
        coachButton.setImage(coachDefault, for: [])
        menuButton.setImage(menuImage, for: [])
       
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    
        switch sender.tag {
        case 1: self.delegate?.homeSegue()
                print("Button Home Pressed")
        break;
        case 2: self.delegate?.notificationSegue()
                print("Button Notif Pressed")//button2
        break;
        case 3: self.delegate?.coachSegue()
                print("Button Coach Pressed")//button3
        break;
        case 4: self.delegate?.menuSegue()
                print("Button menu Pressed")//button4
        break;
        
        
        default: ()
        break;
            
        }

    
    
    
    }
    
    
    
    

}
