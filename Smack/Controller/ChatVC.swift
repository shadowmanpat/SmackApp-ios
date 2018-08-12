//
//  ChatVC.swift
//  Smack
//
//  Created by macbook on 21/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBAction func sendMessageSend(_ sender: Any) {
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var typingUsersLabel: UILabel!
    @IBOutlet weak var sendButtin: NSLayoutConstraint!
    @IBOutlet weak var MessageText: UITextField!
    @IBAction func loginBtnPrsssed(_ sender: Any) {
    }
    @IBOutlet weak var channelLabelTxt: UILabel!
    @IBAction func messageboxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id
            else {return}
        
        if MessageText.text == "" {
            isTyping = false
            messageButton.isHidden = false
            SocketService.instance.socket.emit("stopType", USerDataService.instance.name, channelId)
        }else {
            if isTyping == false {
                
                messageButton.isHidden = true
                SocketService.instance.socket.emit("startType", USerDataService.instance.name, channelId)
            }
            isTyping = true
            
        }
    }
    var isTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
      tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
         messageButton.isHidden = true
        // Do any additional setup after loading the view.
        menuBtn.addTarget(self.removeFromParentViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id &&
                AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                    
            }
        }
//        SocketService.instance.getChatMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0{
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                }
//            }
        }
        SocketService.instance.getTypingUser { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else
            {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != USerDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else{
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLabel.text = "\(names) \(verb) typing a message"
                
            }else{
                self.typingUsersLabel.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name:NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelLabelTxt.text = "#\(channelName)"
//        getMessages()
        getMessages()
    }
    
    @objc func channelSelected(_ notif:Notification){
        updateWithChannel()
        
    }
    @objc func userDataDidChange(_ notif:Notification){
        if AuthService.instance.isLoggedIn {
            //get channels
            onLoginGetMessages()
        } else {
            //
            channelLabelTxt.text = "please login"
            tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelLabelTxt.text = "No Channels"
                }
                //do stuf
            }
        }
    }

    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else {
            return UITableViewCell()
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
