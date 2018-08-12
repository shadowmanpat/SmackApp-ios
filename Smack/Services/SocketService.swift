//
//  SocketService.swift
//  Smack
//
//  Created by macbook on 29/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
//    let socket =


    override init() {
        super.init()
//        let socket = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress]).manager.defaultSocket
    }
    var socket: SocketIOClient = SocketIOClient(manager: URL(string:  BASE_URL)! as! SocketManagerSpec, nsp: "nikos")
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let channel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        let user = USerDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(commpletion: @escaping (_ newMessage: Message) -> Void ){
        socket.on(clientEvent: SocketClientEvent(rawValue: "messageCreated")!) { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else  {return}
             guard let channelId = dataArray[1] as? String else  {return}
             guard let userName = dataArray[2] as? String else  {return}
             guard let userAvatar = dataArray[3] as? String else  {return}
             guard let userAvatarColor = dataArray[4] as? String else  {return}
             guard let id = dataArray[5] as? String else  {return}
             guard let timeStamp = dataArray[6] as? String else  {return}
             let newMessage = Message(message:msgBody,userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor,id : id, timeStamp:timeStamp)
            commpletion(newMessage)
        
            
           
        }
    }
    
    func getTypingUser(_ completionHandler: @escaping (_ typingUser: [String: String]) -> Void){
        socket.on(clientEvent: SocketClientEvent(rawValue: "userTypingUpdate")!) { (dataArray, ack) in
            guard let typingUser = dataArray[0] as? [String:String] else {
                return
            }
            completionHandler(typingUser)
        }
    }
    
    
    
    
    
    
    
    
}
