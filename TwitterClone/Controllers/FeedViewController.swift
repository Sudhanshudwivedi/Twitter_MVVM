//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 20/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit
import SDWebImage

private let resuseIndentifier = "TweetCell"
class FeedViewController: UICollectionViewController {

    //MARK:- Properties
    
    var user:User?{
        didSet{
            configureLeftBarItem()
        }
    }
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTweets()
    }
    
    
    //MARK:Api's
    func fetchTweets(){
        TweetService.shared.fetchTweets { (tweet) in
            print("Debug: \(tweet)")
        }
    }
    
    //MARK:- Helpers
    func setupUI(){
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: resuseIndentifier)
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44 )
        navigationItem.titleView = imageView
        

    }
    
    func configureLeftBarItem(){
        guard let user = user else { return }
        
        let profileImageView  = UIImageView()
        profileImageView.contentMode  = .scaleToFill
        profileImageView.backgroundColor = .blue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: profileImageView)
    }
 }

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIndentifier, for: indexPath) as! TweetCell
        
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
