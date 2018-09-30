//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Rish on 29/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCellCollectionViewCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
