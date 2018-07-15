//
//  SocketIOManager.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 14/07/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import Foundation
import SocketIO

class Manager : NSObject {
    
    
    static let chat_Server_URL : String = "http://13.59.14.56:5000/"
    let token = LoginScreenViewController.token
    let socket = SocketManager(socketURL: URL(string: "http://13.59.14.56:5000/")!)
    
//   let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!,config: [.log(true),.connectParams(["token": "\(token)"])])
//    
    
    
    func addHandlers() {
        socket.defaultSocket.on("myEvent") {data, ack in
            print(data)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
}
