//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Rish on 25/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    override init() {
        super.init()
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
            let height : CGFloat = 200
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
        UIView.animate(withDuration: 0.4) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
}
