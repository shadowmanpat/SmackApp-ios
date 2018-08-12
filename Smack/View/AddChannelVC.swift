//
//  AddChannelVC.swift
//  Smack
//
//  Created by macbook on 29/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

   
    @IBOutlet weak var bgVuew: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var name: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    @IBOutlet weak var createChannelPresses: RoundedButton!
    
    @IBAction func CreateChannelPressed(_ sender: Any) {
        guard let channelName = name.text , name.text != "" else {return}
        guard let channelDesc = descriptionTxt.text , descriptionTxt.text != "" else {return}
        SocketService.instance.addChannel(channelName: (channelName), channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var closeModalPresses: UIButton!
    @IBOutlet weak var CloseModalPressed: UIButton!
    
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector (AddChannelVC.closeTap(_:)))
        
        bgVuew.addGestureRecognizer(closeTouch)
        
        name.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
    }
    @objc func closeTap(_ recogizerio:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
