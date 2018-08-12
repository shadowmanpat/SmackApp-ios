//
//  ProfileVcViewController.swift
//  Smack
//
//  Created by macbook on 28/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ProfileVcViewController: UIViewController {
    @IBOutlet weak var profileImg: UIView!
    @IBOutlet weak var userName: UILabel!
    
    @IBAction func logout(_ sender: Any) {
        USerDataService.instance.logout()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    @IBOutlet weak var profileImgView: CircleIamge!
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupView(){
        userName.text = USerDataService.instance.name
        userEmail.text = USerDataService.instance.email
        profileImgView.image =     UIImage(named: USerDataService.instance.avatarName)
        let closetouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVcViewController.closeTap(_:)))
        profileImg.addGestureRecognizer(closetouch)
    }

    @objc func closeTap(_ recognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion:nil)
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
