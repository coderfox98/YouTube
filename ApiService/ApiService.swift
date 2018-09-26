//
//  ApiService.swift
//  YouTube
//
//  Created by Rish on 26/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class ApiService : NSObject {
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion : @escaping (([Video]) -> ())) {
    let url : URL = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
    URLSession.shared.dataTask(with: url) { (data, response, error) in
    if error != nil {
    print(error)
    return
    }
    else
    {
    do{ let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    print(json)
    var videos = [Video]()
    for dictionary in json as! [[String:AnyObject]] {
    let video = Video()
    video.title = dictionary["title"] as! String
    video.thumbnailImage = dictionary["thumbnail_image_name"] as! String
    
    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
    
    let channel = Channel()
    channel.name = channelDictionary["name"] as! String
    channel.userProfileImage = channelDictionary["profile_image_name"] as! String
    video.channel = channel
    videos.append(video)
    }
    DispatchQueue.main.async {
    completion(videos)
    }
    
    }
    catch let jsonError {
    print(jsonError)
    }
    
    }
    }.resume()
    }
}
