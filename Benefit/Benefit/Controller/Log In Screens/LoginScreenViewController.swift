//
//  ViewController.swift
//  Benefit
//
//  Created by Delta One on 13/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

//colour of bottom border of the text field before the animation starts
let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
//colour of bottom border of the text field after the animation has finished
let finalColourOfBorder = UIColor.darkGray.cgColor

class LoginScreenViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var invalidUsernameLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
 
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var enteredPassword: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar(with: "LOG IN OR SIGN UP")
        registerForKeyboardNotifications()
        invalidUsernameLabel.text = ""
        incorrectPasswordLabel.text = ""
        initialize(usernameTextField)
        initialize(passwordTextField)
        hideKeyboard()
    }

    //MARK: - Manage Content Hidden Under Keyboard
    
    func registerForKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification)
    {
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.currentTextField
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
   
    //MARK: - Log In
    
    func logIn()
    {
        let errorInUsername = true
        let errorInPassword = true
        if errorInUsername
        {
            invalidUsernameLabel.text = "Invalid"
            invalidUsernameLabel.textColor = UIColor.red
            let border = CALayer()
            addInitial(border, to: usernameTextField)
            runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
            
        }
        if errorInPassword
        {
            incorrectPasswordLabel.text = "Incorrect"
            incorrectPasswordLabel.textColor = UIColor.red
            let border = CALayer()
            addInitial(border, to: passwordTextField)
            runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
        }
        
        print("Login Button Pressed")
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton)
    {
        logIn()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton)
    {
        print("Signup Button Pressed")
    }
    
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton)
    {
        print("Forgot Password Button Pressed")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
}

//MARK: - Text Field Delegate Methods

extension LoginScreenViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        currentTextField = textField
        textField.textAlignment = .justified
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionPush, to: finalColourOfBorder)
        
        if currentTextField == usernameTextField
        {
            invalidUsernameLabel.text = ""
        }
        
        if currentTextField == passwordTextField
        {
            incorrectPasswordLabel.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionFade, to: initialColourOfBorder )
        currentTextField = nil
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
            logIn()
            
        }
        return false
    }
}

extension UITextField
{
    func setLeftPaddingPoints(_ amount:CGFloat)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController: UIGestureRecognizerDelegate
{
    func setupNavigationBar(with text: String)
    {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Oswald-Medium", size: 25)!]
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
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.delegate = self
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)

    }
}

