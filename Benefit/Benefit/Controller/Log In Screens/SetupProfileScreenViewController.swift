//
//  SetupProfileScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 19/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class SetupProfileScreenViewController: UIViewController
{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genderDisplay: UIButton!
    @IBOutlet weak var selectFemaleButton: UIButton!
    @IBOutlet weak var selectMaleButton: UIButton!
    
    @IBOutlet weak var feetToggleButton: UIButton!
    @IBOutlet weak var inchesToggleButton: UIButton!
    @IBOutlet weak var cmToggleButton: UIButton!
    
    @IBOutlet weak var kgToggleButton: UIButton!
    @IBOutlet weak var lbsToggleButton: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet var radioButtons: [UIButton]!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentlySetGender = "female"
    let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
    let finalColourOfBorder = UIColor.darkGray.cgColor
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var activeField: UITextField?
    var currentlySetHeightUnit = "cm"
    var currentlySetWeightUnit = "kg"
    var currentlySelectedLifestyleIndex = 0
    let lifestyleIndices = [0: "Sedentary", 1: "Moderate", 2: "Active", 3: "Very Active"]
    var units: [String: UIButton]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        units = ["cm": cmToggleButton, "ft": feetToggleButton, "in": inchesToggleButton, "kg": kgToggleButton, "lbs": lbsToggleButton]
        //setupNavigationBar(with: "SET UP YOUR PROFILE")
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        setupRounded(button: genderDisplay)
        setupRounded(button: selectMaleButton)
        setupRounded(button: selectFemaleButton)
       
        for radioButton in radioButtons
        {
            if radioButton.tag == 0
            {
                radioButton.setImage(#imageLiteral(resourceName: "ic_radio_on_24dp"), for: .normal)
            }
            else
            {
                radioButton.setImage(#imageLiteral(resourceName: "ic_radio_off_24dp"), for: .normal)
            }
        }
        registerForKeyboardNotifications()
        initialize(ageTextField)
        initialize(heightTextField)
        initialize(weightTextField)
        hideKeyboard()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToBMIScreen"
        {
            let destinationVC = segue.destination as! BMIScreenViewController
            destinationVC.delegate = self
            destinationVC.height = Double(heightTextField.text!)!
            destinationVC.weight = Double(weightTextField.text!)!
            destinationVC.heightUnit = currentlySetHeightUnit
            destinationVC.weightUnit = currentlySetWeightUnit
            print(destinationVC.height, destinationVC.weight)
        }
    }
    
    @IBAction func femaleSelected(_ sender: UIButton)
    {
        if currentlySetGender == "male"
        {
            currentlySetGender = "female"
            sender.setImage(#imageLiteral(resourceName: "ic_female_sel_24dp"), for: .normal)
             sender.backgroundColor = UIColor(hex: "5FC0E5")
            selectMaleButton.setImage(#imageLiteral(resourceName: "ic_male_not_24dp"), for: .normal)
            selectMaleButton.backgroundColor = UIColor(hex: "F0F0F0")
            genderDisplay.setImage(#imageLiteral(resourceName: "female_img"), for: .normal)
        }
    }
    
    @IBAction func maleSelected(_ sender: UIButton)
    {
        if currentlySetGender == "female"
        {
            currentlySetGender = "male"
            sender.setImage(#imageLiteral(resourceName: "ic_male_sel_24dp"), for: .normal)
            sender.backgroundColor = UIColor(hex: "5FC0E5")
            selectFemaleButton.setImage(#imageLiteral(resourceName: "ic_female_not_24dp"), for: .normal)
            selectFemaleButton.backgroundColor = UIColor(hex: "F0F0F0")
            genderDisplay.setImage(#imageLiteral(resourceName: "male_img"), for: .normal)
        }
    }
    
    @IBAction func cmSelected(_ sender: UIButton)
    {
        if currentlySetHeightUnit != "cm"
        {
            changeButtonStatesTo(on: "cm", off: currentlySetHeightUnit)
            currentlySetHeightUnit = "cm"
        }
    }
    
    @IBAction func inchesSelected(_ sender: UIButton)
    {
        if currentlySetHeightUnit != "in"
        {
            changeButtonStatesTo(on: "in", off: currentlySetHeightUnit)
            currentlySetHeightUnit = "in"
        }
    }
    @IBAction func feetSelected(_ sender: UIButton)
    {
        if currentlySetHeightUnit != "ft"
        {
            changeButtonStatesTo(on: "ft", off: currentlySetHeightUnit)
            currentlySetHeightUnit = "ft"
        }
    }
    
    @IBAction func kgSelected(_ sender: UIButton)
    {
        if currentlySetWeightUnit != "kg"
        {
            changeButtonStatesTo(on: "kg", off: currentlySetWeightUnit)
            currentlySetWeightUnit = "kg"
        }
    }
    
    @IBAction func lbsSelected(_ sender: UIButton)
    {
        if currentlySetWeightUnit != "lbs"
        {
            changeButtonStatesTo(on: "lbs", off: currentlySetWeightUnit)
            currentlySetWeightUnit = "lbs"
        }
    }
    
    func changeButtonStatesTo(on buttonName1: String, off buttonName2: String)
    {
        units[buttonName1]!.backgroundColor = UIColor(hex: "5FC0E5")
        units[buttonName1]!.setTitleColor(UIColor.white, for: .normal)
        units[buttonName2]!.backgroundColor = UIColor(hex: "F0F0F0")
        units[buttonName2]!.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func radioButtonSelected(_ sender: UIButton)
    {
        if currentlySelectedLifestyleIndex != sender.tag
        {
            radioButtons[currentlySelectedLifestyleIndex].setImage(#imageLiteral(resourceName: "ic_radio_off_24dp"), for: .normal)
            radioButtons[currentlySelectedLifestyleIndex].isEnabled = true
            radioButtons[sender.tag].setImage(#imageLiteral(resourceName: "ic_radio_on_24dp"), for: .normal)
            currentlySelectedLifestyleIndex = sender.tag
        }
       
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
    }
    


    func addDoneButtonOnKeyboard(for textField: UITextField, with text: String)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: text, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.nextButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }

    @objc func nextButtonAction()
    {
        let superview = activeField?.superview
        
        if let nextField = superview?.superview?.viewWithTag((activeField?.tag)! + 1) as? UITextField
        {
            nextField.becomeFirstResponder()
        }
        else
        {
            activeField?.resignFirstResponder()
        }
    }
    
    
    //MARK: - Initialize Text Fields
    
    func initialize(_ textField: UITextField)
    {
        textField.delegate = self
        textField.setLeftPaddingPoints(10)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if textField.tag == 2
        {
            addDoneButtonOnKeyboard(for: textField, with: "Done")
        }
        else
        {
            addDoneButtonOnKeyboard(for: textField, with: "Next")
        }
        //To remove the autofill accessory view option
        if #available(iOS 11, *)
        {
            textField.textContentType = UITextContentType("")
        }
    }
}

extension SetupProfileScreenViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeField = textField
        currentTextField = textField
        textField.textAlignment = .justified
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionPush, to: finalColourOfBorder)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeField = nil
        let border = CALayer()
        addInitial(border, to: textField)
        runTransition(on: border, with: kCATransitionFade, to: initialColourOfBorder )
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if ageTextField.text != "", heightTextField.text != "", weightTextField.text != ""
        {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }
    }
}

extension UIViewController
{
    func setupRounded(button: UIButton)
    {
        // Shadow and Radius for Circle Button
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
//        button.layer.shadowRadius = 1.0
//        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = button.frame.width / 2
        
    }
}



