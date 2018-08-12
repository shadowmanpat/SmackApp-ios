//
//  RoundedButton.swift
//  Smack
//
//  Created by macbook on 22/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    
    @IBInspectable var cornernRadius:CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornernRadius
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornernRadius
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
