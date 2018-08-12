//
//  AuthService.swift
//  Smack
//
//  Created by macbook on 22/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var  authToke: String {
        get {
            return defaults.value(forKey: ΤΟΚΕΝ_ΚΕY) as! String
        }
        set {
            defaults.set(newValue, forKey: ΤΟΚΕΝ_ΚΕY )
        }
    }
    
    var  user: String {
        get {
            return defaults.value(forKey: EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: EMAIL )
        }
    }
    
    func registerUSer(email:String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Conntent-type":"application/json; charset=utf-8",
            
        ]
        let body : [String: Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString(completionHandler:
            { (response) in
            
                if (response.result.error == nil) {
                    completion(true)
                } else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        })
    }
    func loginUser(email:String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
       
        let body : [String: Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON(completionHandler: { (response) in
            
            
            if (response.result.error == nil) {
                guard let data = response.data else {return}
                
                do{
                    let json = try JSON(data: data)
                    self.user = json["user"].stringValue
                    self.authToke = json["toke"].stringValue
                }catch{
                    
                }
                
                
                
                
//                if let json = response.result.value as? Dictionary<String,Any>{
//                    if let email = json["user"] as? String {
//                        self.user = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToke = token
//                    }
//
//                }
                self.isLoggedIn = true
                completion(true)
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
       
    }
    
    func createUser(id: String, color:String, avatarName:String, emaill: String, name:String, completion: @escaping CompletionHandler)
    
    {
        let lowerCaseEmail = emaill.lowercased()
        
        let body:[String: Any] = [
            "name":name,
            "email":lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": color
        ]
        
     
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON (completionHandler:
            { (response) in
                if response.result.error == nil{
                    guard let data = response.data else { return }
                    
                    self.setUserInfo(data: data)
                    completion(true)
                }else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
                
            
        })
        
      
    }
    func findUserByEmail(completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(user)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else { return }
                
               self.setUserInfo(data: data)
                  completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
        
        func setUserInfo(data: Data){
            do{
                let json = try JSON(data:data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                USerDataService.instance.setUserData(id: id, color: color, avatarName: name, emaill: email, name: name)
              
            }catch{
                
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
 
