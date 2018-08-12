//
//  MessageService.swift
//  Smack
//
//  Created by macbook on 29/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    var unreadChannels = [String]()
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_URL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data  = response.data else {return}
                
                do
                {if let json  = try JSON(data:data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                        
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADEDF, object: nil)
                    completion(true)
                }
                }catch{
                    
                }
            }
                
         else {
            completion(false)
            debugPrint(response.result.error as Any)
        }
        }}
    func clearChannels(){
        channels.removeAll()
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @ escaping CompletionHandler){
    
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON{ (response) in
            
            if response.result.error == nil {
                self.clearChannels()
                guard let data = response.data else {return}
              
                do{
                    if let json = try JSON(data: data).array{
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue 
                            let userAvatar  = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColo"].stringValue
                            let timestamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp)
                            
                            self.messages.append(message)
                            
                           
                            
                        }
                     completion(true)
                    }
                 
                }catch{
                        
                    }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                
            }
            
        }
        
        func clearMessages(){
            messages.removeAll()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
