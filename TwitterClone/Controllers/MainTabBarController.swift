//
//  MainTabBarControllerViewController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 20/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: Properties
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: Helpers
    func configureViewController(){
        
        let exploreNav = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: ExploreViewController())
        let feedNav = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: FeedViewController())
        let notificationsNav = templateNavigationController(image: UIImage(named: "like"), rootViewController: NotificationsViewController())
        let conversationsNav = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationViewController())
        
        viewControllers = [feedNav,exploreNav,notificationsNav,conversationsNav]
    }
    
    func templateNavigationController(image:UIImage?,rootViewController:UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
