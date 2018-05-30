//
//  NavBar.swift
//  Benefit
//
//  Created by Delta One on 23/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift
import JTHamburgerButton
import SideMenu

protocol MyNavigationBarDelegate
{
    func hamButtonWasTriggered()
    func hamButtonWasDismissed()
}

class NavBar: UIView, UISideMenuNavigationControllerDelegate
{
    @IBOutlet weak var hamButton: JTHamburgerButton!
    @IBOutlet var contentView: NavBar!
    @IBOutlet weak var coachButton: UIButton!
    @IBOutlet weak var notificationsButton: MIBadgeButton!
    
    var delegate: MyNavigationBarDelegate?
    var isSideBarOnScreen = false
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setUpNavBar()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setUpNavBar()
    }
    
    private func setUpNavBar()
    {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        hamButton.lineColor = .black
        
        if isSideBarOnScreen
        {
            hamButton.currentMode = .cross
        }
        else
        {
            hamButton.currentMode = .hamburger
        }
        
        hamButton.updateAppearance()
    }
    
    @IBAction func hamButtonPressed(_ sender: JTHamburgerButton)
    {
        delegate?.hamButtonWasTriggered()
    }
    

}
