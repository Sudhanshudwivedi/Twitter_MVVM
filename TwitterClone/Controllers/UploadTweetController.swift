//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 11/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK:- Properties
    
    private let user:User?
    
    private lazy var actionButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(width: 62, height: 32)
        button.layer.cornerRadius = 32/2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        image.clipsToBounds = true
        return image
    }()
    
    private let captionTextView = CaptionTextView()
    
    
    init(user:User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK:- Selector
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet(){
        guard let captionText = captionTextView.text else {return}
        TweetService.shared.uploadTweet(caption: captionText) { (error, ref) in
            if let error = error{
                print("Debug: Failed to upload tweet with error \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK:- API
    
    //MARK:- Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        configureNavBar()
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView,captionTextView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user?.profileImageUrl, completed: nil)
    }
    
    func configureNavBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel
            , target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
