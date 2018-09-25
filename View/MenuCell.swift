//
//  MenuCell.swift
//  YouTube
//
//  Created by Rish on 22/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class MenuCell : BaseCell {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }}
        
        override var isSelected: Bool {
        didSet {
        imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
        }
    
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        addSubview(imageView)
//        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
}
