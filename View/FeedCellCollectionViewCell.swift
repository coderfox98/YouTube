//
//  FeedCellCollectionViewCell.swift
//  YouTube
//
//  Created by Rish on 29/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class FeedCellCollectionViewCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var videos : [Video]?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false 
        return cv
    }()
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.frame.height ).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        collectionView.register(ViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let count = videos?.count {
                return count
            }
            return 0
        }
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ViewCell
            cell.video = videos?[indexPath.item]
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 32) * 9 / 16
            return CGSize(width: frame.width, height: height + 16 + 8 + 44 + 16)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
  
}
