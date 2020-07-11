//
//  TweetService.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 11/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption:String,completion:@escaping(Error?,DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        let values = ["uid":uid, "timeStamp":Int(NSDate().timeIntervalSince1970),"likes":0,"retweets":0,"caption":caption] as [String:Any]
        
        REF_TWEET.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void){
        var tweets = [Tweet]()
        REF_TWEET.observe(.childAdded) { (snapshot) in
            guard let tweetInfo = snapshot.value as? [String:Any] else {return}
            let tweetId = snapshot.key
            let tweet = Tweet(with: tweetId, dic: tweetInfo)
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
