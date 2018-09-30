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
    var thumbnail_image_name : String = ""
    var number_of_views : NSNumber = 0
    var uploadDate : NSDate?
    var channel : Channel = Channel()
    var duration : NSNumber = 0
}


class Channel {
    var name : String = "Default username"
    var profile_image_name : String = "kanye_profile"
}
