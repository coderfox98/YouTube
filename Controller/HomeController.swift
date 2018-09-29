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
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        setupMenuBar()
        setupNavBarButtons()
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = .white
        collectionView.register(FeedCellCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
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
        settingsLauncher.showSettings()
    }
    
    lazy var settingsLauncher : SettingsLauncher = {
       let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func showSettingsController(setting : Setting) {
        let settingsLauncher = UIViewController()
        settingsLauncher.view.backgroundColor = .white
        settingsLauncher.navigationItem.title = setting.nameLabel.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white] 
        navigationController?.pushViewController(settingsLauncher, animated: true)
    }
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    
    let redView : UIView = {
       let rv = UIView()
        rv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        view.addSubview(redView)
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true 
        
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func scrollToMenuIndex(menu: Int) {
        let indexPath = IndexPath(item: menu, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        print(index)
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        let colors : [UIColor] = [.red,.yellow,.blue,.brown]
//        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    

}


