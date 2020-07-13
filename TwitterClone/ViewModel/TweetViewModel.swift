//
//  TwitterViewModel.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 13/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import UIKit
struct TweetViewModel {
    
    let tweet:Tweet?
    let user:User
    var profileImageUrl : URL?{
        return user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.userName.lowercased())",
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet:Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
