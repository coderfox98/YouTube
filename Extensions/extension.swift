//
//  extension.swift
//  YouTube
//
//  Created by Rishabh Raj on 25/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadDataWithInputUrl(urlString : String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
            if error != nil {
                print(error)
                return
            }
            else {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }.resume()

    }
}
