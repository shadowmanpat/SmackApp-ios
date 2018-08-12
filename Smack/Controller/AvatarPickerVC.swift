//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by macbook on 23/07/2018.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit


class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Variables
    var avatarType = AvatarCell.AvatarType.dark
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configureCell(index: indexPath.item, type: avatarType)
                        return cell
                    }
        
                    return AvatarCell()
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
//            return cell
//        }
//
//        return AvatarCell()
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numberOfColumns = 4
        }
        let spaceBetweenCels : CGFloat = 10
        
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width) - (numberOfColumns - 1) * spaceBetweenCels) / numberOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark{
            USerDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else{
            USerDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
            
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
