//
//  ChatViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 14/07/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON



class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

   
   

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
     let token = LoginScreenViewController.token
    var last : Int = 0
     var messageArray : [String] = ["Welcome to chat"]
     let time1 = Date().timeIntervalSinceNow * 1000
     let client = SocketIOManager()
     var output = [String : AnyObject]()
     var authorId : Int = 0
    var chatMessages = [[String : AnyObject]]()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        

        configureTableView()
    
        client.establishConnection()
     
        
       
        print(time1)
        
        client.receivedMessage { (dataArray) in
            
            print("In The chat controller", dataArray)
            
            print(dataArray)
            self.chatMessages.append(dataArray)
            print(self.chatMessages)
            self.messageTableView.reloadData()
            
            
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
  
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        if messageTextfield.text == ""{
            print("message Empty")
        }
        else{
//            messageArray.append(messageTextfield.text!)
            chatMessages.append(["author": 0 as AnyObject, "message": messageTextfield.text! as AnyObject])
            messageTableView.reloadData()
            client.messageSend(message: messageTextfield.text!, author: 0, timeStamp: time1)
            print("New message sent")
        }
        
        
      
       
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        //server code
        
        
        //setting views
        self.messageTextfield.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextfield.text = ""
        
        
    }
    
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    
    func configureTableView() {
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        messageTextfield.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
        
        
    }
    //MARK: - TextField Delegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
       //  last = indexPath.row
        print(chatMessages.count)
        let currentChatMessage = chatMessages[indexPath.row]
        let message = currentChatMessage["message"] as! String
        let author = currentChatMessage["author"] as! Int
        
        cell.messageBody.text = message
        
        switch author {

        case 0:
            cell.senderUsername.text = "You"

            break
        case 1:
            cell.senderUsername.text = "Coach"
              cell.messageBackground.backgroundColor = UIColor.gray
            break
        case 2:
            cell.senderUsername.text = "Nutritionist"
             cell.messageBody.textColor = .white
            cell.messageBackground.backgroundColor = UIColor.blue
            break

        default:
            cell.senderUsername.text = "You"
        }
        
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 0.01) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.01) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    
  
        
    @IBAction func toDashboardButtonPressed(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
          let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
         self.present(navController, animated: true, completion: nil)
        
    }
    
    
    

}
