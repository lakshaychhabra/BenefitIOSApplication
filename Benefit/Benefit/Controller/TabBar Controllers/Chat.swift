//
//  Chat.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 16/07/18.
//  Copyright © 2018 IOSD. All rights reserved.
//
import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
     let token = LoginScreenViewController.token
    
     static let sharedInstance = SocketIOManager()
     lazy var manager = SocketManager(socketURL: URL(string: "http://13.59.14.56:5000/")!,config: [.log(true),.connectParams(["token": token])])
      var socket:SocketIOClient!
    
    override init() {
        super.init()
        
        self.socket = manager.defaultSocket
        

        
    }
    
    func messageSend(message: String, author: Int, timeStamp : Double){
        
        print("Sending Messages")
        socket.emit("new message", ["message" : message, "author" : author, "timestamp" : timeStamp])
        
        
    }
    
    func receivedMessage (completionHandler: @escaping ([String : AnyObject]) -> Void) {
        
        socket.on("new message") { (data, ack) in
            
//            print("New messagessss")
//            print(data)
//            print("data1")
//            print("everything", data[0] as! [String: AnyObject])
            var output = [String: AnyObject]()
            output = data[0] as! [String: AnyObject]
           // print(output["message"]!)
            
           completionHandler(output)
            
        }
        
    }
    
    
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
}
