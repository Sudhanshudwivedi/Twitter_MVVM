//
//  Tweet.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 12/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation

struct Tweet {
    let caption:String
    let tweetId:String
    let uid:String
    let likes:String
    var timestamp:Date!
    let retweetCount:Int
    var user: User
    init(with tweetId:String,user: User, dic:[String:Any]) {
        self.tweetId = tweetId
        self.caption = dic["caption"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        self.likes = dic["likes"] as? String ?? ""
        self.retweetCount = dic["retweetCount"] as? Int ?? 0
        self.user = user
        if let timestamp = dic["timestamp"] as? Double{
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
