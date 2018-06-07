//
//  ViewController.swift
//  Benefit
//
//  Created by Delta One on 13/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GGLSignIn
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit






//colour of bottom border of the text field before the animation starts
let initialColourOfBorder = UIColor.init(ciColor: CIColor(red: 240, green: 240, blue: 240)).cgColor
//colour of bottom border of the text field after the animation has finished
let finalColourOfBorder = UIColor.darkGray.cgColor

class LoginScreenViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate
{
    
    static var token = "1"
    var output : JSON = []
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var invalidUsernameLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
 
    var keyboardIsOnScreen = false
    var currentTextField: UITextField!
    var enteredPassword: String?
    var messageRecieved : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar(with: "LOG IN OR SIGN UP")
       // registerForKeyboardNotifications()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        invalidUsernameLabel.text = ""
        incorrectPasswordLabel.text = ""
        initialize(usernameTextField)
        initialize(passwordTextField)
        hideKeyboard()
    }

    func activityIndicatorFunc() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    //MARK: - Google Signin
  
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let idToken = user.authentication.idToken // Safe to send to the server
            let email = user.profile.email
            let name = user.profile.name
           // print(email)
            
            let parameters : [String : String] = ["email" : email!,"name" : name!, "googleToken" : idToken!]
            let url = "http://13.59.14.56:5000/api/v1/auth/login/google"
           // let url2 = "http://13.59.14.56:5000/api/v1/auth/signup"
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicatorFunc()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
                print(response)
                
                
                let data : JSON = JSON(response.result.value!)
                print(data)
                self.output = data["token"]["token"]
                if let  message = data["message"].rawString() {
                    self.messageRecieved = message
                }
                if self.output != JSON.null  {
                    
                    if let token1 = self.output.rawString() {
                        LoginScreenViewController.token = token1
                        //        print(self.token)
                    }
                    self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    print("See Token")
                    print(LoginScreenViewController.token)
                }
                else {
                    self.displayAlert(title: "Error Login Through Google", message: "Please try Custom login or try again after some time. ")
                }
            }
       
        } else {
           print(error)
            }
        }
    
    
    
//    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
//    //    myActivityIndicator.stopAnimating()
//    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    //Mark: - Google SignIn Button
    
    @IBAction func googleSigninButtonPresses(_ sender: Any) {
        //Calling the property directly on button
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    //Mark: - Facebook SignIn
    
    
    @IBAction func fbSignInButtonPressed(_ sender: Any) {
    
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                let loginResult = fbloginresult.grantedPermissions
                if(loginResult?.contains("email") != nil)
                {
                    self.getFBUserData()
                }else{
                    print("No email found, user canceled")
                }
            
            }
            else{
                print("User pressed back button \(String(describing: error))")
                 self.displayAlert(title: "Error Login Through Facebook", message: "Please try Custom login or try again after some time. ")
            }
          }
        
        }
        
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            
            activityIndicatorFunc()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
           // print(FBSDKAccessToken.current().tokenString)
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result!)
                    let info = result as! [String : AnyObject]
                    let name = info["name"] as! String
                    let email = info["email"] as! String
                    let idToken = FBSDKAccessToken.current().tokenString
                    
                    let parameters : [String : String] = ["email" : email,"name" : name, "fbToken" : idToken!]
                    let url = "http://13.59.14.56:5000/api/v1/auth/login/facebook"
                    
                    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    
                   
                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
                        print(response)
                        
                        
                        let data : JSON = JSON(response.result.value!)
                        print(data)
                        self.output = data["token"]["token"]
                        if let  message = data["message"].rawString() {
                            self.messageRecieved = message
                        }
                        if self.output != JSON.null  {
                            
                            if let token1 = self.output.rawString() {
                                LoginScreenViewController.token = token1
                                //        print(self.token)
                            }
                            self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                            
                            activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            print("See Token")
                            print(LoginScreenViewController.token)
                        }
                        else {
                            self.displayAlert(title: "Error Login Through Facebook", message: "Please try Custom login or try again after some time. ")
                        }
                    }
                    
                }
                else{
                    print("Cant fetch fb data")
                }
            })
        }
    }
        
    
   // Facebook Login Ends

    
    
  
    
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
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Missing Info", message: "Must Enter Email and Password")
            
        }
        else{
            //spinners
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            //spinners end
            
            if let username = usernameTextField.text {
                if let password = passwordTextField.text{
                    let parameters : [String : String] = ["email" : username, "password" : password]
                    let url = "http://13.59.14.56:5000/api/v1/auth/login"
                    
                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
                        
                        
                        print(response)
                        
                        let data : JSON = JSON(response.result.value!)
                        print(data)
                        self.output = data["token"]["token"]
                        if let  message = data["message"].rawString() {
                            self.messageRecieved = message
                        }
                        if self.output != JSON.null  {
                            
                            if let token1 = self.output.rawString() {
                                LoginScreenViewController.token = token1
                                //        print(self.token)
                            }
                            self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                            
                            activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            print("See Token")
                            print(LoginScreenViewController.token)
                        }
                            
                        else{
                            activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            if self.messageRecieved == "User doesn´t exist" {
                                print("No User Exist")
                                self.noUserFound()
                            }
                            if self.messageRecieved == "Invalid Password." {
                                print("Wrong Password")
                                self.wrongPassword()
                            }
                            
                        }
                        
                    }
                }
           }
        }
        print("Login Button Pressed")
    }
    
    
    func noUserFound(){
        invalidUsernameLabel.text = "Invalid"
        invalidUsernameLabel.textColor = UIColor.red
        let border = CALayer()
        addInitial(border, to: usernameTextField)
        runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
    }
    func wrongPassword(){
        incorrectPasswordLabel.text = "Incorrect"
        incorrectPasswordLabel.textColor = UIColor.red
        let border = CALayer()
        addInitial(border, to: passwordTextField)
        runTransition(on: border, with: kCATransitionFade, to: UIColor.red.cgColor)
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
    
   
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

