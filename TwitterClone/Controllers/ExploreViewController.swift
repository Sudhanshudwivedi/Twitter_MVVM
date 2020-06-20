//
//  ExploreViewController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 20/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    //MARK: Properties
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }

}
