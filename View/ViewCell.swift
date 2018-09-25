//
//  ViewCell.swift
//  YouTube
//
//  Created by Rish on 21/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class ViewCell: BaseCell {
   
    var video : Video? {
        didSet {
            titleLabel.text = video?.title
            thumbnailImageView.image = video?.thumbnailImage
            userProfileImageView.image = video?.channel.userProfileImage
            
            if let numberOfViews = video?.numberOfViews, let channelName = video?.channel.name {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                subtitleTextView.text = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 1 year ago"
            }
            
            
        }
    }
    
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "photo-1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "photo-2")
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Havana - Remix Version"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Rish Studio • 12,067,832 views • 1 year ago"
        textView.textContainerInset = UIEdgeInsets(top: -2, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint : NSLayoutConstraint?
    
    override func setupViews() {
        
        let inset : CGFloat = 16
        let height : CGFloat = 44
        
        addSubview(thumbnailImageView)
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(inset + height + (inset/2))).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: inset).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -inset).isActive = true
        
        addSubview(separatorView)
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: inset / 2).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: inset).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        
        addSubview(titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0, constant: 22))
        
        addSubview(subtitleTextView)
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: subtitleTextView, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    
}

