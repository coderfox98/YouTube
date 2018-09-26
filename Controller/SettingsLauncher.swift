//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Rish on 25/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class Setting {
    let nameLabel : SettingName
    let imageName : String
    init(nameLabel : SettingName, imageName : String) {
        self.nameLabel = nameLabel
        self.imageName = imageName
    }
}

enum SettingName : String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case PrivacyPolicy = "Terms & Privacy Policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    
}

class SettingsLauncher: NSObject ,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let cellHeight : CGFloat = 50
    
    var homeController : HomeController?
    
    let settings : [Setting] = {
        let setting = Setting(nameLabel: .Settings, imageName: "settings")
        let setting2 = Setting(nameLabel: .PrivacyPolicy, imageName: "privacy")
        let setting3 = Setting(nameLabel: .SendFeedback, imageName: "feedback")
        let setting4 = Setting(nameLabel: .Help, imageName: "help")
        let setting5 = Setting(nameLabel: .SwitchAccount, imageName: "switch_account")
         let setting6 = Setting(nameLabel: .Cancel, imageName: "cancel")
        return [setting, setting2, setting3, setting4, setting5, setting6]
        
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed : Bool) in
            let setting = self.settings[indexPath.item]
            if setting.nameLabel != .Cancel{
            self.homeController?.showSettingsController(setting: setting)
            }
            }
    }
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    let blackView = UIView()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            let height : CGFloat = CGFloat(settings.count) * cellHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            blackView.frame = window.frame
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height - height, width: window.frame.width, height: height)
            }, completion: nil)
            
        }
    }
    
    @objc func handleTap() {
      
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }, completion: nil)
    }
    
}
