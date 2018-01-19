//
//  RegistrationScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 16/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class RegistrationScreenViewController: UIViewController
{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var invalidEmailAddressLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    
    //colour of bottom border of the text field before the animation starts
    let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
    //colour of bottom border of the text field after the animation has finished
    let finalColourOfBorder = UIColor.darkGray.cgColor
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var activeField: UITextField?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar()
        registerForKeyboardNotifications()
        invalidEmailAddressLabel.text = ""
        incorrectPasswordLabel.text = ""
        initialize(usernameTextField)
        initialize(passwordTextField)
        initialize(emailAddressTextField)
        hideKeyboard()
        
    }
    
    func setupNavigationBar()
    {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        let label = UILabel()
        label.text = "CREATE A NEW ACCOUNT"
        label.font = UIFont(name: "Oswald-Medium", size: 25)
        label.textAlignment = .left
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton)
    {
       next()
    }
    
    func next()
    {
        let errorInEmailAddress = true
        let errorInPassword = true
        if errorInEmailAddress
        {
            invalidEmailAddressLabel.text = "Invalid"
            invalidEmailAddressLabel.textColor = UIColor.red
            let border = CALayer()
            addInitial(border, to: emailAddressTextField)
            runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
            
        }
        if errorInPassword
        {
            incorrectPasswordLabel.text = "Atleast 8 characters"
            incorrectPasswordLabel.textColor = UIColor.red
            let border = CALayer()
            addInitial(border, to: passwordTextField)
            runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
        }
        
        print("Next Button Pressed")
    }
    
    //MARK: - Manage Content Hidden Under Keyboard
    
    func registerForKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification)
    {
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField
        {
            if (!aRect.contains(activeField.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification)
    {
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    //MARK: - Initialize Text Fields
    
    func initialize(_ textField: UITextField)
    {
        textField.delegate = self
        textField.setLeftPaddingPoints(10)
        
        //To remove the autofill accessory view option
        if #available(iOS 11, *)
        {
            textField.textContentType = UITextContentType("")
        }
    }
    
    
    //Add Initial Bottom Border To Text Fields
    
    func addInitial(_ border: CALayer, to textField: UITextField)
    {
        let width = CGFloat(2.0)
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        border.borderColor = initialColourOfBorder
        border.borderWidth = width
        
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    //MARK: - Transition For The Bottom Border In Text Fields
    
    func runTransition(on transitioningLayer: CALayer, with transitionType: String, to colour: CGColor?)
    {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = transitionType
        
        transitioningLayer.add(transition,
                               forKey: "transition")
        
        transitioningLayer.borderColor = colour
    }
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
 
    }

}

extension RegistrationScreenViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeField = textField
        currentTextField = textField
        textField.textAlignment = .justified
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionPush, to: finalColourOfBorder)
        
        if currentTextField == emailAddressTextField
        {
            invalidEmailAddressLabel.text = ""
        }
        
        if currentTextField == passwordTextField
        {
            incorrectPasswordLabel.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeField = nil
        if currentTextField == passwordTextField
        {
            currentTextField.rightView = nil
        }
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionFade, to: initialColourOfBorder )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
        {
            nextField.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
            next()
            
        }
        return false
    }
}
