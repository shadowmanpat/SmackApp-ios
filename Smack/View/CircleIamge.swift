//
//  CircleIamge.swift
//  Smack
//
//  Created by macbook on 25/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit


@IBDesignable
class CircleIamge: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
