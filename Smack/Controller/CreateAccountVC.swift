//
//  CreateAccountVC.swift
//  Smack
//
//  Created by macbook on 21/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit


class CreateAccountVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    var avatarImg = "profileDefault"
    var avarColor = "[ 0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if USerDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: USerDataService.instance.avatarName)
            avatarImg = USerDataService.instance.avatarName
        }
        if avatarImg.contains("light") && bgColor == nil{
            userImg.backgroundColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func closeUnwind(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = true
        spinner.startAnimating()
        guard let email = email.text , self.email.text != "" else{
            return
        }
        guard let pass = password.text , password.text != "" else{
            return
        }
        guard let name = username.text , username.text != "" else{
            return
        }
        AuthService.instance.registerUSer(email: email, password: pass)
        { (success) in
            if(success){
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("logged in user", AuthService.instance.authToke)
                        AuthService.instance.createUser(id: email, color: self.avarColor, avatarName: self.avatarImg, emaill: email, name: name, completion: { (success) in
                            if(success) {
                                self.spinner.isHidden =  true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name:NOTIF_USER_DATA_DID_CHANGE, object:nil)
                                
                            }
                        })
                    }
                })
                print("registered user!")
            }else{
                print("registered fail!")
            }
        }
    }
    @IBAction func pickAvatarPresses(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUT, sender: nil)
    }
    @IBAction func changeBgPressed(_ sender: Any) {
        let r = CGFloat( arc4random_uniform(255)) / 255
        let g = CGFloat( arc4random_uniform(255)) / 255
        let b = CGFloat( arc4random_uniform(255)) / 255
        bgColor =  UIColor(red: r, green: g, blue: b, alpha: 1)
        avarColor="[\(r),\(g),\(b)]"
        UIView.animate(withDuration: 0.2) {
              self.userImg.backgroundColor = self.bgColor
        }
     
    }
    func setupView(){
        spinner.isHidden = true
        username.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        email.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap) )
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
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
