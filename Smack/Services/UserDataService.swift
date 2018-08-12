//
//  UserDataService.swift
//  Smack
//
//  Created by macbook on 22/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import Foundation

class USerDataService{
    static let instance = USerDataService()
    
    public private(set) var id = ""
    
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name =  ""
    
    func setUserData(id: String, color:String, avatarName:String, emaill: String, name:String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = emaill
        self.name = name
    }
   
    func setAvatarName(avatarName name: String){
        avatarName = name
    }
    
    func returnUIColor(componens:String) ->UIColor{
        let scanner = Scanner(string: componens)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
    
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        return newUIColor
    }
    
    func logout(){
        id = ""
    
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToke = ""
        MessageService.instance.clearChannels()
//        MessageService.instance.clearMessages()
    }
}
