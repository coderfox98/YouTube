//
//  Video.swift
//  YouTube
//
//  Created by Rish on 23/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class Video : NSObject {
    var title : String = "Ed Sheeran (Default Title)"
    var thumbnailImage : UIImage = UIImage(named: "photo-1")!
    var numberOfViews : NSNumber = 0
    var uploadDate : NSDate?
    var channel : Channel = Channel()
}


class Channel {
    var name : String = "Default username"
    var userProfileImage : UIImage = UIImage(named: "kanye_profile")!
}
