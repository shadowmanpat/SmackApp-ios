//
//  MessageCell.swift
//  Smack
//
//  Created by macbook on 08/08/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImg: CircleIamge!
    @IBOutlet weak var UserNAmeLabe: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(message: Message){
        messageLabel.text = message.message
        UserNAmeLabe.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor =
        USerDataService.instance.returnUIColor(componens: message.userAvatarColor)
    }

}
