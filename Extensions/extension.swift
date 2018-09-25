//
//  extension.swift
//  YouTube
//
//  Created by Rishabh Raj on 25/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView {
    var imageUrlString : String?
    func loadDataWithInputUrl(urlString : String) {
        imageUrlString = urlString
        let url = URL(string: urlString)
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
             }
        
        
        URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
            if error != nil {
                print(error)
                return
            }
            else {
                DispatchQueue.main.async {
                    let imageToCahce = UIImage(data: data!)
                    if self.imageUrlString == urlString {
                    self.image = imageToCahce
                    }
                    imageCache.setObject(imageToCahce!, forKey: urlString as AnyObject)
                }
            }
        }.resume()

    }
}
