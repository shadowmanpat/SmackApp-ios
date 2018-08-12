//
//  LoginVCViewController.swift
//  Smack
//
//  Created by macbook on 21/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController {
    @IBOutlet weak var passordTxt: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let userName = passwordTXTFinal.text, passwordTXTFinal.text != "" else {return}
        guard let pass = password.text, password.text != "" else {
            return
        }
        
        AuthService.instance.loginUser(email: userName, password: pass) { (response) in
            if response {
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE,object: nil)
               
            }
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBOutlet weak var passwordTXTFinal: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userNAmeTxt: UIStackView!
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUT, sender: nil)
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpView(){
        spinner.isHidden = true
        passwordTXTFinal.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
     
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
