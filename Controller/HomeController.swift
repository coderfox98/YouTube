//
//  HomeController
//  YouTube
//
//  Created by Rish on 21/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
//    let videos : [Video] = {
//        var video1 = Video()
//        video1.title = "Ed Sheeran - Perfect featuring Beyone and me "
//        video1.thumbnailImage = UIImage(named: "photo-1")!
//        video1.channel.userProfileImage = UIImage(named: "kanye_profile")!
//        video1.channel.name = "Kanye Channel"
//        video1.numberOfViews = 121321312
//
//        var video2 = Video()
//        video2.title = "Ed Sheeran - Don't"
//        video2.thumbnailImage = UIImage(named: "photo-2")!
//        video2.channel.userProfileImage = (UIImage(named: "taylor_swift_profile")?.withRenderingMode(.alwaysTemplate))!
//        video2.channel.name = "Ed Sheeran"
//        video2.numberOfViews = 12132131223234
//        return [video1, video2]
//    }()

    
    var videos : [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        collectionView.backgroundColor = .white
        collectionView.register(ViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    func fetchVideos() {
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
                    self.videos = [Video]()
                    for dictionary in json as! [[String:AnyObject]] {
                        let video = Video()
                        video.title = dictionary["title"] as! String
                        video.thumbnailImage = dictionary["thumbnail_image_name"] as! String
                        
                        let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                        
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as! String
                        channel.userProfileImage = channelDictionary["profile_image_name"] as! String
                        video.channel = channel
                        self.videos?.append(video)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
                catch let jsonError {
                    print(jsonError)
                }
                
            }
        }.resume()
    }
    
    func setupNavBarButtons() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    @objc func handleSearch() {
        print(123)
    }
    
    @objc func handleMore() {
        print(123)
    }
    let menuBar : MenuBar = {
       let mb = MenuBar()
        
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = videos?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ViewCell
        cell.video = videos?[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 8 + 44 + 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


