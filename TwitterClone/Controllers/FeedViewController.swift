//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 20/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    //MARK: Properties
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Helpers
    func setupUI(){
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
  
}
