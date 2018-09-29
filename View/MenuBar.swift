//
//  MenuBar.swift
//  YouTube
//
//  Created by Rish on 22/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let images = ["home", "trending", "subscriptions", "account" ]
    var homeController : HomeController?
    
        lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
            cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self 
        return cv
    }()
    
    let cellId = "cellId"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: .bottom)
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
//        let x = CGFloat(indexPath.item) * self.frame.width / 4
//        horizontalBarLeftAnchorConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//       
        homeController?.scrollToMenuIndex(menu: indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


