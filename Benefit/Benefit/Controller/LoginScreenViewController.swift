//
//  ViewController.swift
//  Benefit
//
//  Created by Delta One on 13/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var invalidUsernameLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //colour of bottom border of the text field before the animation starts
    let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
    //colour of bottom border of the text field after the animation has finished
    let finalColourOfBorder = UIColor.darkGray.cgColor
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var enteredPassword: String?
    //var activeField: UITextField?
    var forwardArrowIsOnScreen = false
    var backwardArrowIsOnScreen = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar()
        //To Remove The Horizontal Line In The Navigation Bar
        
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
       
        
        registerForKeyboardNotifications()
        invalidUsernameLabel.text = ""
        incorrectPasswordLabel.text = ""
        initialize(usernameTextField)
        initialize(passwordTextField)
        
        hideKeyboard()
    }
    
    func setupNavigationBar()
    {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        let label = UILabel()
        label.text = "LOG IN OR SIGN UP"
        label.font = UIFont(name: "Oswald-Medium", size: 25)
        label.textAlignment = .left
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
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
    
    @IBAction func loginPressed(_ sender: UIButton)
    {
        logIn()
    }
    
    @IBAction func signupPressed(_ sender: UIButton)
    {
        print("Signup Button Pressed")
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
        //activeField = textField
        currentTextField = textField
        textField.textAlignment = .justified
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionPush, to: finalColourOfBorder)
        
        if currentTextField == usernameTextField
        {
            invalidUsernameLabel.text = ""
        }
        
        if currentTextField == passwordTextField && !forwardArrowIsOnScreen
        {
            incorrectPasswordLabel.text = ""
            addBackwardArrow(to: textField)
            backwardArrowIsOnScreen = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        //activeField = nil
        if currentTextField == passwordTextField
        {
            currentTextField.rightView = nil
        }
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
    
    func addBackwardArrow(to textField: UITextField)
    {
        let forwardButton = UIButton(type: .custom)
        forwardButton.setImage(UIImage(named: "ic_arrow_back_24dp.png"), for: .normal)
        forwardButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        forwardButton.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        forwardButton.imageView?.contentMode = .scaleAspectFit
        forwardButton.addTarget(self, action: #selector(self.showForgotPasswordPrompt), for: .touchUpInside)
        textField.rightView = forwardButton
        textField.rightViewMode = .always
    }
    
    func addForwardArrow(to textField: UITextField)
    {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "ic_arrow_forw_24dp.png"), for: .normal)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        backButton.frame = CGRect(x: 0, y: 0, width: CGFloat(50), height: CGFloat(25))
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        currentTextField.leftView = backButton
        currentTextField.leftViewMode = .always
    }
    
    func addForgotPasswordButton(to textField: UITextField)
    {
        let x = CGFloat((currentTextField.frame.size.width - 154) / 2)
        let y = CGFloat((currentTextField.frame.size.height - 42) / 2)
        
        let forgotPasswordButton = UIButton(type: .custom)
        forgotPasswordButton.setTitle("FORGOT PASSWORD", for: .normal)
        forgotPasswordButton.backgroundColor = UIColor.clear
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Oswald-Medium", size: 20)
        forgotPasswordButton.setTitleColor(UIColor.black, for: .normal)
        forgotPasswordButton.frame = CGRect(x: x, y: y, width: 154, height: 42)
        forgotPasswordButton.imageView?.contentMode = .scaleAspectFit
        forgotPasswordButton.addTarget(self, action: #selector(self.goToForgotPassword), for: .touchUpInside)
        
        currentTextField.addSubview(forgotPasswordButton)
    }
    
    @objc func showForgotPasswordPrompt()
    {
        enteredPassword = currentTextField.text
        passwordTextField.text = ""
        passwordTextField.rightView = nil
        passwordTextField.tintColor = UIColor.clear
        addForwardArrow(to: passwordTextField)
        forwardArrowIsOnScreen = true
        backwardArrowIsOnScreen = false
        addForgotPasswordButton(to: passwordTextField)
        
    }
    
    @objc func goBack()
    {
        passwordTextField.becomeFirstResponder()
        passwordTextField.leftView = nil
        passwordTextField.text = enteredPassword
        passwordTextField.setLeftPaddingPoints(10)
        for subView in passwordTextField.subviews
        {
            if subView.isMember(of: UIButton.self)
            {
                subView.removeFromSuperview()
            }
            
        }
        addBackwardArrow(to: passwordTextField)
        forwardArrowIsOnScreen = false
        backwardArrowIsOnScreen = true
        passwordTextField.tintColor = UIColor.black
    }
    @objc func goToForgotPassword()
    {
        print("Forgot Password Button Tapped")
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

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)

    }
}

