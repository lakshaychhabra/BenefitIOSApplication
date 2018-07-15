//
//  ChatViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 14/07/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import SocketIO



class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
   

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
     let token = LoginScreenViewController.token
    
  //  let socket = SocketManager(socketURL: URL(string: "http://13.59.14.56:5000/")!)
    
    var messageArray : [String] = ["Welcome to chat"]
    lazy var manager = SocketManager(socketURL: URL(string: "http://13.59.14.56:5000/")!,config: [.log(true),.connectParams(["token": token])])
     var socket:SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.socket = manager.defaultSocket
         self.socket.connect();
        
         self.setSocketEvents()
         configureTableView()

    }
    
    
    private func setSocketEvents()
    {
        self.socket.on(clientEvent: .connect) {data, ack in
            print(data)
            print("socket connected");
        }
        
        self.socket.on("new message") {data, ack in
            print("data ndsjkvsbvbsdbvjbvsbvkjbvjkbvjkbvdsbvjdvbjkdsbvkjsbvsvjksbvbvbvjk")
            self.messages()
        }
    }
    
    
    func messages(){
        
        print("New message received")
        
        
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
        
        cell.messageBody.text = messageArray[indexPath.row]
        cell.senderUsername.text = "You"
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
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
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        if messageTextfield.text == ""{
            
        }else{
            messageArray.append(messageTextfield.text!)
            messageTableView.reloadData()
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
        
    @IBAction func toDashboardButtonPressed(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyDashboard") as! HomeScreenViewController
        
          let navController : UINavigationController = UINavigationController(rootViewController: newViewController)
        
         self.present(navController, animated: true, completion: nil)
        
    }
    
    
    

}
