//
//  ChannelVC.swift
//  Smack
//
//  Created by macbook on 21/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func addChannel(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated:true,completion: nil)
        }
        
        
    }
    
    @IBOutlet weak var loginBtnPressed: UIButton!
    @IBOutlet weak var loginBtnPress: UIButton!
    
    @IBOutlet weak var userImg: CircleIamge!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }

    @IBOutlet weak var tableView: UITableView!
    @IBAction func login(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = ProfileVcViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
             performSegue(withIdentifier: TO_LOGIN, sender:nil)
        }
       
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADEDF, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id &&
                AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func userDataDidChange(_ notif:Notification){
        if(AuthService.instance.isLoggedIn) {
            loginBtnPress.setTitle(USerDataService.instance.name, for: .normal)
            userImg.image = UIImage(named:USerDataService.instance.avatarName)
        }else{
            loginBtnPress.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    @objc func channelsLoaded(_ notif: Notification){
            tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
        
        
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
        
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
