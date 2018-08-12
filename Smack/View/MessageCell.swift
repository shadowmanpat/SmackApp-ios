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
        
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStamp.text = finalDate
        }
    }

}
