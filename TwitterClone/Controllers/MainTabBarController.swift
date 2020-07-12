//
//  MainTabBarControllerViewController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 20/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit
import Firebase
class MainTabBarController: UITabBarController {
    
    //MARK:- Properties
    
    var user:User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else{return}
            guard let feed = nav.viewControllers.first as? FeedViewController else{return}
            feed.user = user
        }
    }
    let actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside )
        return button
    }()
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        authenticateUserAndConfigureUI()
    }
    
    
    //MARK: Selectors
    @objc func actionButtonTap(){
        guard let user = self.user else {return}
        let viewController = UploadTweetController(user: user)
        let nav =  UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
    
    //MARK:-Api's

    func authenticateUserAndConfigureUI(){
        
        if (Auth.auth().currentUser == nil) {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else{
            print("Debug : User is currently logged In")
            configureViewController()
            configureUI()
            fetchUser()
        }
    }
    
    
    func fetchUser(){
        UsersService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    
    func logUserOut(){
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Debug : Failed to signout with error \(error.localizedDescription)")
        }
    }
    
    
        //MARK:- Helpers
    
    func configureUI(){
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor ,paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configureViewController(){
        
        let exploreNav = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreViewController())
        let feedNav = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()))
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
