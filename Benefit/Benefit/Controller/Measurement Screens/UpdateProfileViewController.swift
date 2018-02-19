//
//  UpdateProfileViewController.swift
//  Benefit
//
//  Created by Delta One on 17/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var genderDisplay: UIButton!
    @IBOutlet weak var selectFemaleButton: UIButton!
    @IBOutlet weak var selectMaleButton: UIButton!
    
    
    @IBOutlet weak var heightCMToggleButton: UIButton!
    @IBOutlet weak var heightFeetToggleButton: UIButton!
    @IBOutlet weak var heightInchesToggleButton: UIButton!
    
    @IBOutlet weak var weightKGToggleButton: UIButton!
    @IBOutlet weak var weightLBSToggleButton: UIButton!
    
    @IBOutlet weak var waistCMToggleButton: UIButton!
    @IBOutlet weak var waistInchesToggleButton: UIButton!
    
    @IBOutlet weak var neckCMToggleButton: UIButton!
    @IBOutlet weak var neckInchesToggleButton: UIButton!
    
    @IBOutlet weak var hipCMToggleButton: UIButton!
    @IBOutlet weak var hipInchesToggleButton: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var waistTextField: UITextField!
    @IBOutlet weak var neckTextField: UITextField!
    @IBOutlet weak var hipTextField: UITextField!
    
    var currentlySetGender = "female"
    let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
    let finalColourOfBorder = UIColor.darkGray.cgColor
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var activeField: UITextField?
    
    var currentlySetHeightUnitButton: UIButton!
    var currentlySetWeightUnitButton: UIButton!
    var currentlySetWaistSizeUnitButton: UIButton!
    var currentlySetNeckSizeUnitButton: UIButton!
    var currentlySetHipSizeUnitButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()

    }
    
    func setupViews()
    {
        setupRounded(button: genderDisplay)
        setupRounded(button: selectMaleButton)
        setupRounded(button: selectFemaleButton)
        
        registerForKeyboardNotifications()
        initialize(ageTextField)
        initialize(heightTextField)
        initialize(weightTextField)
        initialize(waistTextField)
        initialize(neckTextField)
        initialize(hipTextField)
        
        currentlySetHeightUnitButton = heightCMToggleButton
        currentlySetWeightUnitButton = weightKGToggleButton
        currentlySetWaistSizeUnitButton = waistCMToggleButton
        currentlySetNeckSizeUnitButton = neckCMToggleButton
        currentlySetHipSizeUnitButton = hipCMToggleButton
        
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
        hideKeyboard()
    }

    
//    func convert(_ value: String, from unit1: String, to unit2: String) -> String
//    {
//
//
//    }
    
    @IBAction func heightToggled(_ sender: UIButton)
    {
        if currentlySetHeightUnitButton != sender
        {
            changeButtonStatesTo(on: sender, off: currentlySetHeightUnitButton)
            currentlySetHeightUnitButton = sender
            
//            if let currentHeight = heightTextField.text
//            {
//                heightTextField.text = convert(currentHeight, from: currentlySetHeightUnitButton.currentTitle!, to: sender.currentTitle!)
//            }
            
        }
    }
    

    @IBAction func weightToggled(_ sender: UIButton)
    {
        if currentlySetWeightUnitButton != sender
        {
            changeButtonStatesTo(on: sender, off: currentlySetWeightUnitButton)
            currentlySetWeightUnitButton = sender
        }
    }
    
    @IBAction func waistToggled(_ sender: UIButton)
    {
        if currentlySetWaistSizeUnitButton != sender
        {
            changeButtonStatesTo(on: sender, off: currentlySetWaistSizeUnitButton)
            currentlySetWaistSizeUnitButton = sender
        }
    }
    
    @IBAction func neckToggled(_ sender: UIButton)
    {
        if currentlySetNeckSizeUnitButton != sender
        {
            changeButtonStatesTo(on: sender, off: currentlySetNeckSizeUnitButton)
            currentlySetNeckSizeUnitButton = sender
        }
    }
    
    @IBAction func hipToggled(_ sender: UIButton)
    {
        if currentlySetHipSizeUnitButton != sender
        {
            changeButtonStatesTo(on: sender, off: currentlySetHipSizeUnitButton)
            currentlySetHipSizeUnitButton = sender
        }
    }
   
    func changeButtonStatesTo(on button1: UIButton, off button2: UIButton)
    {
        button1.backgroundColor = UIColor(hex: "5FC0E5")
        button1.setTitleColor(UIColor.white, for: .normal)
        button2.backgroundColor = UIColor(hex: "F0F0F0")
        button2.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton)
    {
        if sender.currentTitle == "SAVE"
        {
            saveMeasurements()
            sender.setTitle("NEXT", for: .normal)
        }
        else
        {
            performSegue(withIdentifier: "showMeasurementData", sender: self)
        }
        
    }
    
    func saveMeasurements()
    {
        
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
        if textField.tag == 5
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
}

extension UpdateProfileViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        nextButton.setTitle("SAVE", for: .normal)
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
        if ageTextField.text != "", heightTextField.text != "", weightTextField.text != "", waistTextField.text != "", neckTextField.text != "", hipTextField.text != ""
        {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }
    }
}
