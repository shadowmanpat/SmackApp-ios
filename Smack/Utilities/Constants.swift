//
//  Constants.swift
//  Smack
//
//  Created by macbook on 21/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) ->()
//Colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0.5192904538)

//Notifications Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADEDF  = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")

//Url Constans
let BASE_URL = "https://chattychatnikos.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD =  "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL =  "\(BASE_URL)user/byEmail/"
let URL_URL_CHANNEL = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

//Haeaders
let HEADER = [
    "Conntent-type":"application/json; charset=utf-8",
    
]

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUT = "toCreateAccount"
let AVATAR_PICKER = "toAvatarPicker"
let UNWIND = "unwindToChannel"

//User Defaults
let ΤΟΚΕΝ_ΚΕY = "token"
let LOGGED_IN_KEY = "LOGEED_IN_KEY"
let EMAIL = "email"

let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToke)",
    "Conntent-type":"application/json; charset=utf-8",
]
